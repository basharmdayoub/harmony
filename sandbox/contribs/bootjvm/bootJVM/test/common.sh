#!/bin/sh
#
#!
# @file test/common.sh
#
# @brief Common code to build Java test programs for exercising
# various parts of the JVM
#
# This script is common to @b build.sh and @b clean.sh and is not
# designed to do anything on its own.
#
# Each of these directories contains a @b build.sh script.  In addition
# to these, an Eclipse project file is available in each for use with
# the Eclipse C/C++ plugin, so this entire directory tree may be
# imported wholesale into an Eclipse workspace and used without
# changes.  (Eclipse 3.0.2 generated these files.)  Notice that
# the Eclipse setup does not build the documentation set.  This must
# be done manually with the top-level 'build.sh dox'.
#
# Each of these directories also contains a @b clean.sh script which
# removes the output of @b build.sh.
#
# @attention The configuration options stored by 'config.sh' into the
# file @b config/confopts.gcc are @e not directly available to
# Eclipse and @e must be manually entered there after they are
# established by @link config.sh config.sh@endlink.  They
# should be entered in the project build parameters for C/C++ in the
# miscellaneous parameters section.  For example, '-m32' and '-m64'.
# For a command line GCC invocation, the following is a convenient
# way to incorporate the options:
#
# @verbatim
#
#   $ gcc `cat ../config/config_opts_always.gcc` \
#         `cat ../config/config_opts_usually.gcc` -c filename.c ...
#
# @endverbatim
#
# Notice that this script may be run instead of or as well as an
# Eclipse build.  The only difference is where the object files
# are stored.
#
# @see @link test/build.sh test/build.sh@endlink
#
# @see @link test/clean.sh test/clean.sh@endlink
#
# @see @link ./build.sh ./build.sh@endlink
#
# @see @link ./clean.sh ./clean.sh@endlink
#
# @see @link ./common.sh ./common.sh@endlink
#
#
#
# @todo  A Windows .BAT version of this script needs to be written
#
#
# @section Control
#
# \$URL: https://svn.apache.org/path/name/common.sh $ \$Id: common.sh 0 09/28/2005 dlydick $
#
# Copyright 2005 The Apache Software Foundation
# or its licensors, as applicable.
#
# Licensed under the Apache License, Version 2.0 ("the License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
# either express or implied.
#
# See the License for the specific language governing permissions
# and limitations under the License.
#
# @version \$LastChangedRevision: 0 $
#
# @date \$LastChangedDate: 09/28/2005 $
#
# @author \$LastChangedBy: dlydick $
#         Original code contributed by Daniel Lydick on 09/28/2005.
#
# @section Reference
#
#/ /* 
# (Use  #! and #/ with dox_filter.sh to fool Doxygen into
# parsing this non-source text file for the documentation set.
# Use the above open comment to force termination of parsing
# since it is not a Doxygen-style 'C' comment.)
#
#
###################################################################
#
# Script setup
#
chmod -w $0 common.sh

SOURCES=`cat ../config/config_roster_test_java.dox | \
         grep "^ " | \
         sed 's,test/,,;s, \\\,,'`


TARGET_DIRECTORY=bin

TARGET_LIBRARY=$TARGET_DIRECTORY/boottest.jar
TMPDIR=${TMPDIR:-.}
if test ! -d $TMPDIR/.; then TMPDIR=.; fi # Guarantee a valid TMPDIR
TMP_LIBRARY=$TMPDIR/boottest.jar

#
# EOF