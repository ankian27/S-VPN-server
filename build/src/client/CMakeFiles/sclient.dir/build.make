# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ankit/git/new/S-VPN-master

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ankit/git/new/S-VPN-master/build

# Include any dependencies generated for this target.
include src/client/CMakeFiles/sclient.dir/depend.make

# Include the progress variables for this target.
include src/client/CMakeFiles/sclient.dir/progress.make

# Include the compile flags for this target's objects.
include src/client/CMakeFiles/sclient.dir/flags.make

src/client/CMakeFiles/sclient.dir/svpn_client.c.o: src/client/CMakeFiles/sclient.dir/flags.make
src/client/CMakeFiles/sclient.dir/svpn_client.c.o: ../src/client/svpn_client.c
	$(CMAKE_COMMAND) -E cmake_progress_report /home/ankit/git/new/S-VPN-master/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object src/client/CMakeFiles/sclient.dir/svpn_client.c.o"
	cd /home/ankit/git/new/S-VPN-master/build/src/client && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/sclient.dir/svpn_client.c.o   -c /home/ankit/git/new/S-VPN-master/src/client/svpn_client.c

src/client/CMakeFiles/sclient.dir/svpn_client.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sclient.dir/svpn_client.c.i"
	cd /home/ankit/git/new/S-VPN-master/build/src/client && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /home/ankit/git/new/S-VPN-master/src/client/svpn_client.c > CMakeFiles/sclient.dir/svpn_client.c.i

src/client/CMakeFiles/sclient.dir/svpn_client.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sclient.dir/svpn_client.c.s"
	cd /home/ankit/git/new/S-VPN-master/build/src/client && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /home/ankit/git/new/S-VPN-master/src/client/svpn_client.c -o CMakeFiles/sclient.dir/svpn_client.c.s

src/client/CMakeFiles/sclient.dir/svpn_client.c.o.requires:
.PHONY : src/client/CMakeFiles/sclient.dir/svpn_client.c.o.requires

src/client/CMakeFiles/sclient.dir/svpn_client.c.o.provides: src/client/CMakeFiles/sclient.dir/svpn_client.c.o.requires
	$(MAKE) -f src/client/CMakeFiles/sclient.dir/build.make src/client/CMakeFiles/sclient.dir/svpn_client.c.o.provides.build
.PHONY : src/client/CMakeFiles/sclient.dir/svpn_client.c.o.provides

src/client/CMakeFiles/sclient.dir/svpn_client.c.o.provides.build: src/client/CMakeFiles/sclient.dir/svpn_client.c.o

src/client/CMakeFiles/sclient.dir/svpn_fd.c.o: src/client/CMakeFiles/sclient.dir/flags.make
src/client/CMakeFiles/sclient.dir/svpn_fd.c.o: ../src/client/svpn_fd.c
	$(CMAKE_COMMAND) -E cmake_progress_report /home/ankit/git/new/S-VPN-master/build/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object src/client/CMakeFiles/sclient.dir/svpn_fd.c.o"
	cd /home/ankit/git/new/S-VPN-master/build/src/client && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/sclient.dir/svpn_fd.c.o   -c /home/ankit/git/new/S-VPN-master/src/client/svpn_fd.c

src/client/CMakeFiles/sclient.dir/svpn_fd.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sclient.dir/svpn_fd.c.i"
	cd /home/ankit/git/new/S-VPN-master/build/src/client && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /home/ankit/git/new/S-VPN-master/src/client/svpn_fd.c > CMakeFiles/sclient.dir/svpn_fd.c.i

src/client/CMakeFiles/sclient.dir/svpn_fd.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sclient.dir/svpn_fd.c.s"
	cd /home/ankit/git/new/S-VPN-master/build/src/client && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /home/ankit/git/new/S-VPN-master/src/client/svpn_fd.c -o CMakeFiles/sclient.dir/svpn_fd.c.s

src/client/CMakeFiles/sclient.dir/svpn_fd.c.o.requires:
.PHONY : src/client/CMakeFiles/sclient.dir/svpn_fd.c.o.requires

src/client/CMakeFiles/sclient.dir/svpn_fd.c.o.provides: src/client/CMakeFiles/sclient.dir/svpn_fd.c.o.requires
	$(MAKE) -f src/client/CMakeFiles/sclient.dir/build.make src/client/CMakeFiles/sclient.dir/svpn_fd.c.o.provides.build
.PHONY : src/client/CMakeFiles/sclient.dir/svpn_fd.c.o.provides

src/client/CMakeFiles/sclient.dir/svpn_fd.c.o.provides.build: src/client/CMakeFiles/sclient.dir/svpn_fd.c.o

src/client/CMakeFiles/sclient.dir/main_client.c.o: src/client/CMakeFiles/sclient.dir/flags.make
src/client/CMakeFiles/sclient.dir/main_client.c.o: ../src/client/main_client.c
	$(CMAKE_COMMAND) -E cmake_progress_report /home/ankit/git/new/S-VPN-master/build/CMakeFiles $(CMAKE_PROGRESS_3)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object src/client/CMakeFiles/sclient.dir/main_client.c.o"
	cd /home/ankit/git/new/S-VPN-master/build/src/client && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/sclient.dir/main_client.c.o   -c /home/ankit/git/new/S-VPN-master/src/client/main_client.c

src/client/CMakeFiles/sclient.dir/main_client.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sclient.dir/main_client.c.i"
	cd /home/ankit/git/new/S-VPN-master/build/src/client && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /home/ankit/git/new/S-VPN-master/src/client/main_client.c > CMakeFiles/sclient.dir/main_client.c.i

src/client/CMakeFiles/sclient.dir/main_client.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sclient.dir/main_client.c.s"
	cd /home/ankit/git/new/S-VPN-master/build/src/client && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /home/ankit/git/new/S-VPN-master/src/client/main_client.c -o CMakeFiles/sclient.dir/main_client.c.s

src/client/CMakeFiles/sclient.dir/main_client.c.o.requires:
.PHONY : src/client/CMakeFiles/sclient.dir/main_client.c.o.requires

src/client/CMakeFiles/sclient.dir/main_client.c.o.provides: src/client/CMakeFiles/sclient.dir/main_client.c.o.requires
	$(MAKE) -f src/client/CMakeFiles/sclient.dir/build.make src/client/CMakeFiles/sclient.dir/main_client.c.o.provides.build
.PHONY : src/client/CMakeFiles/sclient.dir/main_client.c.o.provides

src/client/CMakeFiles/sclient.dir/main_client.c.o.provides.build: src/client/CMakeFiles/sclient.dir/main_client.c.o

# Object files for target sclient
sclient_OBJECTS = \
"CMakeFiles/sclient.dir/svpn_client.c.o" \
"CMakeFiles/sclient.dir/svpn_fd.c.o" \
"CMakeFiles/sclient.dir/main_client.c.o"

# External object files for target sclient
sclient_EXTERNAL_OBJECTS =

../bin/sclient: src/client/CMakeFiles/sclient.dir/svpn_client.c.o
../bin/sclient: src/client/CMakeFiles/sclient.dir/svpn_fd.c.o
../bin/sclient: src/client/CMakeFiles/sclient.dir/main_client.c.o
../bin/sclient: src/client/CMakeFiles/sclient.dir/build.make
../bin/sclient: ../lib/libsvpn.a
../bin/sclient: src/client/CMakeFiles/sclient.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking C executable ../../../bin/sclient"
	cd /home/ankit/git/new/S-VPN-master/build/src/client && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/sclient.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/client/CMakeFiles/sclient.dir/build: ../bin/sclient
.PHONY : src/client/CMakeFiles/sclient.dir/build

src/client/CMakeFiles/sclient.dir/requires: src/client/CMakeFiles/sclient.dir/svpn_client.c.o.requires
src/client/CMakeFiles/sclient.dir/requires: src/client/CMakeFiles/sclient.dir/svpn_fd.c.o.requires
src/client/CMakeFiles/sclient.dir/requires: src/client/CMakeFiles/sclient.dir/main_client.c.o.requires
.PHONY : src/client/CMakeFiles/sclient.dir/requires

src/client/CMakeFiles/sclient.dir/clean:
	cd /home/ankit/git/new/S-VPN-master/build/src/client && $(CMAKE_COMMAND) -P CMakeFiles/sclient.dir/cmake_clean.cmake
.PHONY : src/client/CMakeFiles/sclient.dir/clean

src/client/CMakeFiles/sclient.dir/depend:
	cd /home/ankit/git/new/S-VPN-master/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ankit/git/new/S-VPN-master /home/ankit/git/new/S-VPN-master/src/client /home/ankit/git/new/S-VPN-master/build /home/ankit/git/new/S-VPN-master/build/src/client /home/ankit/git/new/S-VPN-master/build/src/client/CMakeFiles/sclient.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/client/CMakeFiles/sclient.dir/depend

