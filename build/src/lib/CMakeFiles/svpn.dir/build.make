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
include src/lib/CMakeFiles/svpn.dir/depend.make

# Include the progress variables for this target.
include src/lib/CMakeFiles/svpn.dir/progress.make

# Include the compile flags for this target's objects.
include src/lib/CMakeFiles/svpn.dir/flags.make

src/lib/CMakeFiles/svpn.dir/util.c.o: src/lib/CMakeFiles/svpn.dir/flags.make
src/lib/CMakeFiles/svpn.dir/util.c.o: ../src/lib/util.c
	$(CMAKE_COMMAND) -E cmake_progress_report /home/ankit/git/new/S-VPN-master/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object src/lib/CMakeFiles/svpn.dir/util.c.o"
	cd /home/ankit/git/new/S-VPN-master/build/src/lib && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/svpn.dir/util.c.o   -c /home/ankit/git/new/S-VPN-master/src/lib/util.c

src/lib/CMakeFiles/svpn.dir/util.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/svpn.dir/util.c.i"
	cd /home/ankit/git/new/S-VPN-master/build/src/lib && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /home/ankit/git/new/S-VPN-master/src/lib/util.c > CMakeFiles/svpn.dir/util.c.i

src/lib/CMakeFiles/svpn.dir/util.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/svpn.dir/util.c.s"
	cd /home/ankit/git/new/S-VPN-master/build/src/lib && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /home/ankit/git/new/S-VPN-master/src/lib/util.c -o CMakeFiles/svpn.dir/util.c.s

src/lib/CMakeFiles/svpn.dir/util.c.o.requires:
.PHONY : src/lib/CMakeFiles/svpn.dir/util.c.o.requires

src/lib/CMakeFiles/svpn.dir/util.c.o.provides: src/lib/CMakeFiles/svpn.dir/util.c.o.requires
	$(MAKE) -f src/lib/CMakeFiles/svpn.dir/build.make src/lib/CMakeFiles/svpn.dir/util.c.o.provides.build
.PHONY : src/lib/CMakeFiles/svpn.dir/util.c.o.provides

src/lib/CMakeFiles/svpn.dir/util.c.o.provides.build: src/lib/CMakeFiles/svpn.dir/util.c.o

src/lib/CMakeFiles/svpn.dir/md5.c.o: src/lib/CMakeFiles/svpn.dir/flags.make
src/lib/CMakeFiles/svpn.dir/md5.c.o: ../src/lib/md5.c
	$(CMAKE_COMMAND) -E cmake_progress_report /home/ankit/git/new/S-VPN-master/build/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object src/lib/CMakeFiles/svpn.dir/md5.c.o"
	cd /home/ankit/git/new/S-VPN-master/build/src/lib && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/svpn.dir/md5.c.o   -c /home/ankit/git/new/S-VPN-master/src/lib/md5.c

src/lib/CMakeFiles/svpn.dir/md5.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/svpn.dir/md5.c.i"
	cd /home/ankit/git/new/S-VPN-master/build/src/lib && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /home/ankit/git/new/S-VPN-master/src/lib/md5.c > CMakeFiles/svpn.dir/md5.c.i

src/lib/CMakeFiles/svpn.dir/md5.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/svpn.dir/md5.c.s"
	cd /home/ankit/git/new/S-VPN-master/build/src/lib && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /home/ankit/git/new/S-VPN-master/src/lib/md5.c -o CMakeFiles/svpn.dir/md5.c.s

src/lib/CMakeFiles/svpn.dir/md5.c.o.requires:
.PHONY : src/lib/CMakeFiles/svpn.dir/md5.c.o.requires

src/lib/CMakeFiles/svpn.dir/md5.c.o.provides: src/lib/CMakeFiles/svpn.dir/md5.c.o.requires
	$(MAKE) -f src/lib/CMakeFiles/svpn.dir/build.make src/lib/CMakeFiles/svpn.dir/md5.c.o.provides.build
.PHONY : src/lib/CMakeFiles/svpn.dir/md5.c.o.provides

src/lib/CMakeFiles/svpn.dir/md5.c.o.provides.build: src/lib/CMakeFiles/svpn.dir/md5.c.o

src/lib/CMakeFiles/svpn.dir/crypt.c.o: src/lib/CMakeFiles/svpn.dir/flags.make
src/lib/CMakeFiles/svpn.dir/crypt.c.o: ../src/lib/crypt.c
	$(CMAKE_COMMAND) -E cmake_progress_report /home/ankit/git/new/S-VPN-master/build/CMakeFiles $(CMAKE_PROGRESS_3)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object src/lib/CMakeFiles/svpn.dir/crypt.c.o"
	cd /home/ankit/git/new/S-VPN-master/build/src/lib && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/svpn.dir/crypt.c.o   -c /home/ankit/git/new/S-VPN-master/src/lib/crypt.c

src/lib/CMakeFiles/svpn.dir/crypt.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/svpn.dir/crypt.c.i"
	cd /home/ankit/git/new/S-VPN-master/build/src/lib && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /home/ankit/git/new/S-VPN-master/src/lib/crypt.c > CMakeFiles/svpn.dir/crypt.c.i

src/lib/CMakeFiles/svpn.dir/crypt.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/svpn.dir/crypt.c.s"
	cd /home/ankit/git/new/S-VPN-master/build/src/lib && /usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /home/ankit/git/new/S-VPN-master/src/lib/crypt.c -o CMakeFiles/svpn.dir/crypt.c.s

src/lib/CMakeFiles/svpn.dir/crypt.c.o.requires:
.PHONY : src/lib/CMakeFiles/svpn.dir/crypt.c.o.requires

src/lib/CMakeFiles/svpn.dir/crypt.c.o.provides: src/lib/CMakeFiles/svpn.dir/crypt.c.o.requires
	$(MAKE) -f src/lib/CMakeFiles/svpn.dir/build.make src/lib/CMakeFiles/svpn.dir/crypt.c.o.provides.build
.PHONY : src/lib/CMakeFiles/svpn.dir/crypt.c.o.provides

src/lib/CMakeFiles/svpn.dir/crypt.c.o.provides.build: src/lib/CMakeFiles/svpn.dir/crypt.c.o

# Object files for target svpn
svpn_OBJECTS = \
"CMakeFiles/svpn.dir/util.c.o" \
"CMakeFiles/svpn.dir/md5.c.o" \
"CMakeFiles/svpn.dir/crypt.c.o"

# External object files for target svpn
svpn_EXTERNAL_OBJECTS =

../lib/libsvpn.a: src/lib/CMakeFiles/svpn.dir/util.c.o
../lib/libsvpn.a: src/lib/CMakeFiles/svpn.dir/md5.c.o
../lib/libsvpn.a: src/lib/CMakeFiles/svpn.dir/crypt.c.o
../lib/libsvpn.a: src/lib/CMakeFiles/svpn.dir/build.make
../lib/libsvpn.a: src/lib/CMakeFiles/svpn.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking C static library ../../../lib/libsvpn.a"
	cd /home/ankit/git/new/S-VPN-master/build/src/lib && $(CMAKE_COMMAND) -P CMakeFiles/svpn.dir/cmake_clean_target.cmake
	cd /home/ankit/git/new/S-VPN-master/build/src/lib && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/svpn.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/lib/CMakeFiles/svpn.dir/build: ../lib/libsvpn.a
.PHONY : src/lib/CMakeFiles/svpn.dir/build

src/lib/CMakeFiles/svpn.dir/requires: src/lib/CMakeFiles/svpn.dir/util.c.o.requires
src/lib/CMakeFiles/svpn.dir/requires: src/lib/CMakeFiles/svpn.dir/md5.c.o.requires
src/lib/CMakeFiles/svpn.dir/requires: src/lib/CMakeFiles/svpn.dir/crypt.c.o.requires
.PHONY : src/lib/CMakeFiles/svpn.dir/requires

src/lib/CMakeFiles/svpn.dir/clean:
	cd /home/ankit/git/new/S-VPN-master/build/src/lib && $(CMAKE_COMMAND) -P CMakeFiles/svpn.dir/cmake_clean.cmake
.PHONY : src/lib/CMakeFiles/svpn.dir/clean

src/lib/CMakeFiles/svpn.dir/depend:
	cd /home/ankit/git/new/S-VPN-master/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ankit/git/new/S-VPN-master /home/ankit/git/new/S-VPN-master/src/lib /home/ankit/git/new/S-VPN-master/build /home/ankit/git/new/S-VPN-master/build/src/lib /home/ankit/git/new/S-VPN-master/build/src/lib/CMakeFiles/svpn.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/lib/CMakeFiles/svpn.dir/depend
