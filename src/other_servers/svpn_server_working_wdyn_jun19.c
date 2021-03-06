#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <pthread.h>
#include <netinet/in.h>
#include <signal.h>
#include <errno.h>
#include <sys/time.h>
#include <time.h>
#include "svpn_server.h"
#include "crypt.h"
#include "svpn_fd.h"
#include "svpn_net.h"
#include "util.h"

//#define MY_BUFFER_LEN 4
#define BUFFER_LEN	64400  //102200
//#define BUFFER_LEN 4096
#define DYN 0
#define ENCRYPT 0

static void svpn_sig_handler(int sig) {
	char buffer[] = "Signal?\n";
	int tmp = write(1, buffer, strlen(buffer));
}

struct tstat
{
	long long total_send;
	long long total_recv;
	long long last_send, last_recv;
	int total_pkgsend, total_pkgrecv;
	int last_pkgsend, last_pkgrecv;
	int speed_send, speed_recv;
	long long ts_last;
	long long ts_current;
};

long long tl_last = 0;
FILE* frec = NULL;


struct tstat stat;

int conn_fd,so_fd;

#define OPT_TH 1024 * 1024
#define TIM_TH 1000000 * 2

char fmtstr[128];

inline void fillnum(char* s, int len, int num)
{
	int lenb = len;
	s += lenb -1;
	while (lenb > 0)
	{
		if (num == 0)
			*s = ' ';
		else if ((len - lenb) % 4 == 3)
			*s = ',';
		else
		{
			*s = '0' + num % 10;
			num /= 10;
		}

		s--;
		lenb--;
	}
}

inline void fillnum64(char* s, int len, long long num)
{
        int lenb = len;
        s += lenb -1;
        while (lenb > 0)
        {
                if (num == 0)
                        *s = ' ';
                else if ((len - lenb) % 4 == 3)
                        *s = ',';
                else
                {
                        *s = '0' + num % 10;
                        num /= 10;
                }

                s--;
                lenb--;
        }
}


inline void output_info()
{
	int tval;

	if (stat.total_send - stat.last_send < OPT_TH &&
		stat.total_recv - stat.last_recv < OPT_TH &&
		stat.ts_current - stat.ts_last < TIM_TH)
			return;

	tval = stat.ts_current - stat.ts_last;
	stat.speed_send = (stat.total_send - stat.last_send) * 1000000 / tval;
	stat.speed_recv = (stat.total_recv - stat.last_recv) * 1000000 / tval;

	fillnum64(fmtstr + 5, 14, stat.total_send);
	fillnum(fmtstr + 22, 9, stat.speed_send);
	fillnum64(fmtstr + 42, 14, stat.total_recv);
	fillnum(fmtstr + 59, 9, stat.speed_recv);
	fprintf(stderr, "%s", fmtstr);

	stat.ts_last = stat.ts_current;
	stat.last_send = stat.total_send;
	stat.last_recv = stat.total_recv;
	stat.last_pkgsend = stat.total_pkgsend;
	stat.last_pkgrecv = stat.total_pkgrecv;

	if ((stat.ts_current / 1000000) % 2 == 0)
	{
		long secc = stat.ts_current / 1000000;
		struct tm tmp = *localtime(&secc);
		if (tl_last != 0)
		{
			if (frec == NULL)
				frec = fopen("svpn.log", "a");
			printf("Rec File %08x \n\n", frec);
			fprintf(frec, "%d.%02d.%02d %02d:%02d:%02d  %9lld\n",
							tmp.tm_year, tmp.tm_mon, tmp.tm_mday,
							tmp.tm_hour, tmp.tm_min, tmp.tm_sec,
							stat.last_recv - tl_last);
			fflush(frec);
		}
		tl_last = stat.last_recv;
	}

}

float diff2float(struct timespec *start, struct timespec *end)
{
		float f;

		struct timespec temp;

		if ((end->tv_nsec - start->tv_nsec)<0) {
     		temp.tv_sec = end->tv_sec - start->tv_sec-1;
	    	temp.tv_nsec = 1000000000 + end->tv_nsec - start->tv_nsec;
			} 
		else {
				temp.tv_sec = end->tv_sec - start->tv_sec;
				temp.tv_nsec = end->tv_nsec - start->tv_nsec;
				}

			f = temp.tv_sec + (temp.tv_nsec / 1000000000.0);

		return f;
}

void my_function(int sig){ // can be called asynchronously
  //flag = 1; // set flag
	close(conn_fd);
	close(so_fd);
}

int svpn_server_handle_thread(struct svpn_server* pvoid)
{
	struct svpn_server *psc = pvoid;

	struct sockaddr_in6 addr;
	socklen_t alen = sizeof(addr);
	int seed = time(NULL); /* get current time for seed */
	struct timespec start, end1, end2, end3, end4;
	float elapsed;
	struct timeval tv;
	int MY_BUFFER_LEN=75;
	char tmpstr[32];
	int te, init_recv_length, rem_len;
	char mytmp;
	int len_buf[MY_BUFFER_LEN];
	len_buf[0]=0;
	//len_buf[1]=0;
	so_fd = psc-> sock_fd;
	struct svpn_net_ipv4_header* pheader = NULL;
	unsigned char buffer[BUFFER_LEN], tmp_buffer[BUFFER_LEN+1400], n_tmp_buffer[BUFFER_LEN],t_tmp_buffer[BUFFER_LEN+1400];
	int ret, uid, len;
	fd_set fd_list;
	
	uint32_t *total_len, *pad_len;
	int rem_offset, pack_flag, pack_len,fd_flag;
	printf("buff==%s==\n",buffer);
	printf("tmpbuf==%s==\n",tmp_buffer);

	strcpy(fmtstr, "Send:99,000,000,000B [9,000,000B/s], Recv:99,000,000,000B [9,000,000B/s]\r");

	memset(&stat, 0, sizeof(stat));
	gettimeofday(&tv, NULL);
	stat.ts_last = tv.tv_sec * 1000000LL + tv.tv_usec;
	printf("Came to line number %d \n", __LINE__);

	signal(SIGINT, my_function); 

	if(listen(psc->sock_fd, 10)== -1){
	printf("an error: %s\n", strerror(errno));}

	//int maxfd = (psc->sock_fd > psc->tun_fd) ? psc->sock_fd : psc->tun_fd;
	//maxfd++;

	conn_fd = accept (psc->sock_fd,NULL,NULL);
	printf("\nconn_fd = %d", conn_fd);
	int maxfd = (conn_fd > psc->tun_fd) ? conn_fd : psc->tun_fd;
	maxfd++;
	while(1)
	{	
		FD_ZERO(&fd_list);
		FD_SET(psc->tun_fd, &fd_list);
		FD_SET(conn_fd, &fd_list);
		printf("Came to line number %d \n", __LINE__);
	
		ret = select(maxfd, &fd_list, NULL, NULL, NULL);
		printf("Came to line number %d \n", __LINE__);	
		if(ret < 0)
		{
			if(errno == EINTR)
				return 0;
				continue;
		}
		printf("Came to line number %d \n", __LINE__);
		// update statistics data----------------------------------------------
		gettimeofday(&tv, NULL);
		stat.ts_current = tv.tv_sec * 1000000LL + tv.tv_usec;
		//--------------------------------------------------------------------
		

		init_recv_length=0;
        //memset(tmp_buffer,'0',BUFFER_LEN + 1400);
		memset(t_tmp_buffer,'0',BUFFER_LEN + 1400);
		rem_len = BUFFER_LEN;
		pack_len = 1400;
		fd_flag=0;
		fflush(stdout);
		printf("Came to line number %d \n", __LINE__);
		fflush(stdout);
		if(FD_ISSET(conn_fd, &fd_list))
		{
			rem_offset=0;
			clock_gettime(CLOCK_REALTIME, &start);
			pack_flag=0;
			printf("Came to line number %d \n", __LINE__);
			while(rem_len > 0){
						printf("Came to line number %d \n", __LINE__);
					//if(FD_ISSET(psc->sock_fd, &fd_list)){
						printf("\nBefore the first recvfrom\n");
						fflush(stdout);
						printf("Came to line number %d \n", __LINE__);
						printf("\nREM_LEN = %d \n",rem_len);
						fflush(stdout);
						
						if(pack_flag==0)	
							len = recv(conn_fd, tmp_buffer + rem_offset, 8 , 0);
						else
							len = recv(conn_fd, tmp_buffer + rem_offset, rem_len , 0);	
						
						if(len < 0)
							printf("an error: %s\n", strerror(errno));	
						printf("\nAfter the first recvfrom\n");
						
						fflush(stdout);
			      
						//if it is reading for the first time (we want to extract all useful data here)---------------------------
							if(pack_flag==0){
								printf("Came to line number %d \n", __LINE__);
							    total_len =   (uint32_t *)&tmp_buffer[0];
							    pad_len   =   (uint32_t *)&tmp_buffer[4];
								printf("\nLength read = %d \n",len);
								printf("\ntotal_len = %d \n",*total_len);
								printf("\npad_len = %d \n",*pad_len);
								//int valid_length = *total_len + 4;
								int valid_length = *total_len + 8;
								if(DYN)
									rem_len = valid_length + *pad_len;
								
								//if it has read the entire data and maybe some padding------------------------------------------- 
								if(valid_length <= len){
											printf("Came to line number %d \n", __LINE__);
											
											memcpy(t_tmp_buffer,tmp_buffer + 8,(*total_len));
											//Processing it now---------------------------------------------------------------
										    //done processing-----------------------------------------------------------------
											rem_offset  = rem_offset  + len;
											//++++++++++++++++++++++++++++++change according to pad len
											rem_len = rem_len - len;			
											printf("Came to line number %d \n", __LINE__);
								}
								//-------------------------------------------------------------------------------------------------


								//if the entire valid data has not been read-------------------------------------------------------
							//	printf("Came to line number %d \n", __LINE__);
								else{
											printf("Came to line number %d \n", __LINE__);
											valid_length = valid_length - len;	
											rem_offset  = rem_offset  + len;
											//++++++++++++++++++++++++++++++change according to pad len
											rem_len = rem_len - len;
											printf("Came to line number %d \n", __LINE__);
											while(valid_length > 0){
													//len= recvfrom(psc->sock_fd, tmp_buffer+rem_offset, valid_length, 0, (struct sockaddr*)&addr, &alen);
													//if(FD_ISSET(psc->sock_fd, &fd_list)){
													printf("\nBefore the second recvfrom\n");
													printf("\nrem_len =%d \n",rem_len);	
													len = recv(conn_fd, tmp_buffer+rem_offset, valid_length, 0);
													printf("\nAfter the second recvfrom\n");
													valid_length = valid_length - len;
													rem_offset   = rem_offset   + len;
													//++++++++++++++++++++++++++++++change according to pad len
													rem_len = rem_len - len;
													//}
													//else{
													//	fd_flag=1;
													//	break;
													//}
													printf("Came to line number %d \n", __LINE__);
											}
											//memcpy(t_tmp_buffer,tmp_buffer+4,(*total_len));
											memcpy(t_tmp_buffer,tmp_buffer + 8,(*total_len));		
											//rem_len = rem_len-(*total_len + 4);
											//rem_len = rem_len-(*total_len + 8);
								}
								//--------------------------------------------------------------------------------------------------
								//if
								pack_flag=1;
							    //CODE TO WRITE IT TO THE TUN	
								printf("Came to line number %d \n", __LINE__);

								             //ignore-------------------------------------------------------
											 //printf("\n the src_addr is %s \n",addr.sa_data);
											 clock_gettime(CLOCK_REALTIME, &end1);
											 elapsed = diff2float(&start, &end1);
											 printf("\nThe elapsed time after receiving : %f \n", elapsed);
											 fflush(stdout);
											 printf("\nlen=%d\n", len);
											 fflush(stdout);
											 if(len <= 0 || len > BUFFER_LEN)
											 continue;
											 //endignore-----------------------------------------------------
											                                                                                                                                        
											                                                                                                                                         
											 //manually overwriting the tmp_buffer[0] value 
											 if(ENCRYPT)
											     uid = t_tmp_buffer[0];
											  else{ 
											 //if it starts with padding-----------------------------
											 //  if(tmp_buffer[4]=='P' && tmp_buffer[5]=='0')
									         //     continue;
									         //------------------------------------------------------
										     int tlen = 0;
											 int ind = 0;       			                                                				                 				 
								    
									 		 //Removing the length info from the buffer-------------------------
			                                 for(te = 0 ; te <= MY_BUFFER_LEN - 1 ; te++){
											  		 if(t_tmp_buffer[ind]=='0'){
											           		 	break;
											   		 }
												 	uint32_t *c_len  = (uint32_t *) &(t_tmp_buffer[ind]);
											 	 	uint32_t cur_len = *c_len;	
											 		memcpy(n_tmp_buffer + tlen, t_tmp_buffer + ind + 4, cur_len);
											 		//*c_len=(uint32_t *) &( t_tmp_buffer[ind] );
											 		len_buf[te] = *c_len;
											
											 		//DEBUG_PRINT____________________________________________________
											 		printf("\n The %d packet length is %d\n  ", te , len_buf[te]);
											 		fflush(stdout);
											 		//_______________________________________________________________
											
													ind = ind + len_buf[te] + 4;
											 		tlen = tlen + len_buf[te];
											 		
											 }
													//Done Removing it---------------------------------------------------
											 		//TIMING CODE_______________________________________________________
											 		clock_gettime(CLOCK_REALTIME, &end2);
											 		elapsed=diff2float(&end1, &end2);
											 		printf("\nThe elapsed time after len_buf update : %f \n", elapsed);
											 		fflush(stdout);
											 		//___________________________________________________________________
									         		
													len = tlen;
											 		mytmp=n_tmp_buffer[0];
											 		uid=188;
											 		n_tmp_buffer[0]=(char)uid;
										}
											 
											  
											 //DEBUG_PRINT__________________________________________________________
											 printf("\nbefore--tempbuf--%c--uid--%d--beforeend\n",n_tmp_buffer[0],uid);
											 fflush(stdout);
											 //_____________________________________________________________________

											 //DEBUG_DEFAULT________________________________________________________
											 if (psc->clients[uid] == NULL)
											    {
											     printf("tempbuf--%c--uid--%d--\n",n_tmp_buffer[0],uid);
											     mprintf(LWARN, "Unknown user #%d\n", uid);
											     continue;
											     }
											 //______________________________________________________________________
											
											 if (ENCRYPT) {
	                                               Decrypt(&(psc->clients[uid]->table), n_tmp_buffer, buffer, len);
	              							}
						    
						              		else {
					                   				memcpy(buffer, n_tmp_buffer, len);
				               					}
											
						 					//DEBUG_PRINT________________________________________________________________
											printf("\nbuffer before typecast\n");
						              		fflush(stdout);					
											//___________________________________________________________________________
											
											//update the first index with the original value
											buffer[0]=mytmp;
											
											//DEBUG_PRINT________________________________________________________________
											 int ccd;
									         for(ccd=0;ccd<len;ccd++){
												 printf("%c ",buffer[ccd]);
											  	if(ccd % 16 == 0) printf("\n");
								             fflush(stdout);
											}			 
											//___________________________________________________________________________
									
									   
								            pheader = (struct svpn_net_ipv4_header*)buffer;
								           
										   	if (pheader->src_ip[0] != psc->local_addr[0] ||
								                pheader->src_ip[1] != psc->local_addr[1] ||
								                pheader->src_ip[2] != psc->local_addr[2] ||
								                pheader->src_ip[3] != uid)
								             {
								                 printf("pheader->src_ip[0] = %d != psc->local_addr[0] = %d\n", pheader->src_ip[0], psc->local_addr[0]);
								                 printf("pheader->src_ip[1] = %d != psc->local_addr[1] = %d\n", pheader->src_ip[1], psc->local_addr[1]);
								                 printf("pheader->src_ip[2] = %d != psc->local_addr[2] = %d\n", pheader->src_ip[2], psc->local_addr[2]);
								                 printf("pheader->src_ip[3] = %d != uid = %d\n", pheader->src_ip[3], uid);
								                 printf("psc->local_addr[3] = %d\n", psc->local_addr[3]);
								
												 mprintf(LWARN, "Invalid password");
								             //  mprintf(LWARN, "Invalid password : %s", inet_ntop(PF_INET6, (char*)&addr + 8, tmpstr, sizeof(tmpstr)));
								                 printf("about to continue...\n");
								                 continue;
								             }
								 
								             if (memcmp(&addr, &psc->clients[uid]->addr, sizeof(addr)) != 0)
								             {
								                memcpy(&psc->clients[uid]->addr, &addr, sizeof(addr));
								                mprintf(LINFO, "Client #%d move to ???", uid);
								                //mprintf(LINFO, "Client #%d move to %s", uid, inet_ntop(PF_INET6, (char*)&addr + 8, tmpstr, sizeof(tmpstr)));
								             }
								
											 stat.total_send += len;
								             stat.total_pkgsend++;
								             output_info();
								             
								             //TIMING_CODE_____________________________________________________________________________
											 clock_gettime(CLOCK_REALTIME, &end3);
								             elapsed=diff2float(&end2, &end3);
								             printf("\nThe elapsed time after printing, memcpy tmp_buf to buf : %f \n", elapsed);
								             fflush(stdout);
											 //________________________________________________________________________________________

											 int var, incr=0,ller;
											 for(var=0;var<te;var++){
												 		printf("Came to line number %d \n", __LINE__);
											     		ller = write(psc->tun_fd, buffer+incr, len_buf[var]);
											       		incr=incr+ller;
											   }
	                                          
											 //TIMING_CODE_____________________________________________________________________________
											 clock_gettime(CLOCK_REALTIME, &end4);
											 elapsed=diff2float(&end3, &end4);
										     printf("\nThe elapsed time after writing : %f \n", elapsed);
				                             fflush(stdout);
											 //_______________________________________________________________________________________

											 
						}
						else{
							printf("Came to line number %d \n", __LINE__);
							 rem_offset  = rem_offset  + len;
							 //++++++++++++++++++++++++++++++change according to pad len
							 rem_len     = rem_len     - len;
							 
							 continue;
						}
					//----------------------------------------------------------------------------------------------------------------------
				//	}
				//	else 
				//	   break;	
				printf("Came to line number %d \n", __LINE__);
			}
			//init_recv_length=BUFFER_LEN;
			 printf("Came to line number %d \n", __LINE__);
		
		}//The main if ends here "if(FD_ISSET(psc->sock_fd, &fd_list))"

		if(FD_ISSET(psc->tun_fd, &fd_list))
		{	printf("BEFORE READ\n");
    		len = read(psc->tun_fd, tmp_buffer, BUFFER_LEN);
			int apk;
			printf("\nAfter Read\n");
			//for(apk=0;apk<len;apk++){
 			//	printf("%c ",buffer[apk]);
              //  if(apk % 16 == 0) printf("\n");
             //	fflush(stdout);
			//}

			printf("\nDone printing\n");

			if (len <= 0 || len > BUFFER_LEN)
				continue;
			
			printf("Came to line number %d \n", __LINE__);
			pheader = (struct svpn_net_ipv4_header*)tmp_buffer;

			uid = pheader->dst_ip[3];
			if (psc->clients[uid] == NULL)
			{
				printf("The ip first part is %d\n",pheader->dst_ip[0]);
				 printf("The ip second part is %d\n",pheader->dst_ip[1]);
				  printf("The ip third part is %d\n",pheader->dst_ip[2]);
				   printf("The ip fourth part is %d\n",pheader->dst_ip[3]);

				mprintf(LWARN, "User #%d not exist", uid);
				continue;
			}

			if (ENCRYPT) {
				Encrypt(&(psc->clients[uid]->table), tmp_buffer, buffer, len);
			} else {
				memcpy(buffer, tmp_buffer, len);
				printf("Came to line number %d \n", __LINE__);
			}
			

			printf("Came to line number %d \n", __LINE__);
			len = send(conn_fd, buffer, BUFFER_LEN, 0);
					
			

			printf("Came to line number %d \n", __LINE__);
			if (len <= 0)
			{
				mprintf(LERROR, "Client #%d disconnected", uid);
				continue;
			}

			// update statistics data
			stat.total_recv += len;
			stat.total_pkgrecv++;
		//	output_info();
		}
		printf("Came to line number %d \n", __LINE__);
	}
	printf("Came to line number %d \n", __LINE__);
	return 0;
}

struct svpn_server *svpn_server_init(const char* configfile)
{
	struct svpn_server *psc;
	struct sigaction sact;
	FILE* fin;
	char tmpstr[128];
	unsigned short port;
	int laddr;

	if ((fin = fopen(configfile, "r")) == NULL)
		return NULL;

	port = 0;
	laddr = 0;
	while (1)
	{
		if (fscanf(fin, "%s", tmpstr) <= 0)
			break;
		if (strcasecmp(tmpstr, "port") == 0)
			fscanf(fin, "%hd", &port);
		else if (strcasecmp(tmpstr, "local") == 0)
		{
			fscanf(fin, "%s", tmpstr);
			laddr = inet_addr(tmpstr);
//		printf("lelelelele%d\nleelelele",laddr);
		}

skipline:
		fgets(tmpstr, sizeof(tmpstr), fin);
	}
	fclose(fin);

	if (port == 0)
	{
		mprintf(LFATAL, "No port specified");
		return NULL;
	}
	if (laddr == 0)
	{
		mprintf(LFATAL, "No local address specified");
		return NULL;
	}

	psc = (struct svpn_server*)malloc(sizeof(struct svpn_server));
	memset(&sact, 0, sizeof(struct sigaction));
	memset(psc, 0, sizeof(struct svpn_server));
   // printf("lelelelele%d\nleelelele",laddr);
	memcpy(psc->local_addr, &laddr, sizeof(laddr));
	mprintf(LINFO, "Assigned local address %d.%d.%d.%d",
				psc->local_addr[0], psc->local_addr[1],
				psc->local_addr[2], psc->local_addr[3]);

	// init socket
	if(svpn_sock_create(psc, port) < 0)
	{
		free(psc);
		return NULL;
	}

	mprintf(LINFO, "Bind Server Port %d", port);

	// init tunnel
	psc->tun_fd = svpn_tun_create(psc->dev_name, laddr);
	if(psc->tun_fd < 0)
	{
		close(psc->sock_fd);
		free(psc);
		return NULL;
	}

	sact.sa_handler = svpn_sig_handler;
	sact.sa_flags &= ~SA_RESTART;
	sigaction(SIGUSR1, &sact, &(psc->old_act));

	return psc;
}

int svpn_server_init_client(struct svpn_server *psc, const char* userlist)
{
	FILE* fin;
	char tmpstr[128];
	unsigned char pmd5[16];
	int tmpint, id;

	if((fin = fopen(userlist, "r")) == NULL)
		return -1;

	memset(psc->clients, 0, sizeof(psc->clients));

	while (1)
	{
		if (fscanf(fin, "%s", tmpstr) <= 0)
			break;
	//	 printf("tmpstr--%s--",tmpstr);
		if (strcasecmp(tmpstr, "user") != 0)
			goto skipline;

		// read id
		if (fscanf(fin, "%d", &id) <= 0)
			goto skipline;
		if (psc->clients[id] != NULL)
		{
			mprintf(LERROR, "User ID duplicated");
			goto skipline;
		}
		// read password
		if (fscanf(fin, "%s", tmpstr) <= 0)
			goto skipline;
		// OK
		psc->clients[id] = 
			(struct svpn_client_node*)malloc(sizeof(struct svpn_client_node));
		MD5Fast(tmpstr, strlen(tmpstr), pmd5);
		BuildTable(&(psc->clients[id]->table), pmd5, id);

		mprintf(LINFO, "User #%d added", id);

skipline:
		fgets(tmpstr, sizeof(tmpstr), fin);
	//printf("tmpstr--%s--",tmpstr);
	}

	fclose(fin);
	return 0;
}
