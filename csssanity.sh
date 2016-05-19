#!/bin/sh
##
# COPYRIGHT (c) 2016 SkyzohKey <skyzohkey@protonmail.com>
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
##

VERSION=0.1.0

if [ -z "$1" ]; then
  echo -e "Usage:   $0 <output_file.min.css>"
  echo -e "Example: $0 static/styles/file.min.css"
  exit 1
fi;

tput bold; tput setaf 4;
echo -e "CSS Sanity v. $VERSION - https://csssanity.pw";
tput sgr0;

FILE=$1
DIR=$(dirname $1)
TMPFILE=$(mktemp)

# Remove old minified file and tmp (if any).
rm -f $1
rm -f $TMPFILE

# Merge files into one.
cat ${DIR}/*.css > $TMPFILE

tput bold; tput setaf 2;
echo -e "I: Wow, files got merged into $TMPFILE so much faster!";
tput sgr0;

# Minify css.
cat $TMPFILE \
  | tr '\r\n' ' ' \
  | perl -pe 's:/\*.*?\*/::g' \
  | sed \
    -e 's/\s\+/ /g' \
    -e 's/\([#\.:]\)\s\?/\1/g' \
    -e 's/\s\?\([;{}]\)\s\?/\1/g' \
    -e 's/\s\?\([,!+~>]\)\s\?/\1/g' \
    -e 's/;}/}/g' \
    -e 's/0\(\.[0-9]\)/\1/g' \
    -e 's/\(background\|outline\|border\(-left\|-right\|-top\|-bottom\)\?\):none\b/\1:0/g' \
    -e 's/}[^{]\+{}/}/g' \
  > $1

tput bold; tput setaf 2;
echo -e "I: Yay! $1 was created with much fucking success!"
tput sgr0;

tput bold; tput setaf 3;
echo -e "I: Cleanup temporary files..."
tput sgr0;

rm -f $TMPFILE


exit 0
