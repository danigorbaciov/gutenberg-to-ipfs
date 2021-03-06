#!/usr/bin/env bash

set -x

lang="$1"
format="html"
archive="archive-$lang"

if [ -z "$lang" -o -z "$format" ]; then
    echo "Usage: ./download <lang>"
fi

mkdir "$archive"
cd "$archive"

echo "Starting download with get"
wget -nv -m -H "http://www.gutenberg.org/robot/harvest?filetypes[]=$format&langs[]=$lang"

cd ..

if [ -d index ]; then
    echo "Index already downloaded. To redownload remove the 'index' folder."
    exit
fi

mkdir index
cd index

echo "Download index" # generates cache/epub
wget -nv -O - "http://www.gutenberg.org/cache/epub/feeds/rdf-files.tar.bz2" | tar -jxf -
