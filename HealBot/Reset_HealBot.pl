#!/usr/bin/perl -w
## Copyright (c) 2011 Garrett Taylor [see 'MIT Copyright License' below]
## The shebang line should allow you to type './Reset_Healbot.pl' 
#    on the command line, hit <enter> and be on your way.
## Trouble?  Check to make sure that you: 
#    a) are using Mac OS X 10.3+ ( Panther, Tiger, Leopard, Snow Leopard, Lion )
#    b) have perl installed properly ( it is by default on OS X ).
#    c) have permission to execute this file.
#    d) haven't moved this file from it's initial directory in the HealBot plugin.

## FindBin has been part of the Core install for some time now (c. May 1997)
#    so using it is pretty safe since this script is only for Mac OS X.
use FindBin;

## Intitalize the variables we'll be working with
my $count = 0; my $dir = ''; my @deleted = ();

## If you haven't moved this script (you haven't, right?) this will
#    point the find to the right directory.
$dir = $FindBin::Bin."/../../../WTF/Account";

## Change the working directory (makes the interactive part more readable)
#    or die because it can't find the directory.
chdir( $dir ) or die("Problem with '$dir': $!\n");

## Printing some pretty-fying space and instructions
print ("-" x 10); print "\n";
print "At the following prompts 'y<enter>' WILL delete all HealBot WTF files, while any other input (even just <enter>) will NOT delete the files.\n";
print ("-" x 10); print "\n";

## Executing a shell command (a BSD-esque find):
# qx(                       Run and capture the output of a shell command
#    find                   The shell command we're running
#    .                      The current directory [ see chdir() above ]
#    -type f                Match only objects the are files (as opposed to folders, etc.)
#    -iname '*healbot.*'    Case insensitive match of file names to *healbot.*
#    -exec                  Execute a command on each match
#        rm -iv {} \\;           Delete (with confirmation) each matched file
# )
@deleted = qx(find . -type f -iname '*healbot.*' -exec rm -iv {} \\;);

## Count the captured output to determine the number of deleted files
$count = scalar( @deleted );

## More pretty-fying space
print ("-" x 10); print "\n";

## Print pretty-fied summary count of files deleted
print "Deleted ".($count||'0')." file".( $count==1 ? '.' : 's.' )."\n";

## Exit with typical Unix value of 0 for success, 1 if nothing was deleted (error or otherwise)
exit( ( $count > 0 ) ? 0 : 1 );

## MIT Copyright License
# Copyright (c) 2011 Garrett Taylor
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.