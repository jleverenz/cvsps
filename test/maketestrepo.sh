#!/bin/sh

CVSROOT="$PWD/repo"
WORKINGDIR="$PWD/wd"
export CVSROOT

rm -rf "$CVSROOT" "$WORKINGDIR" || exit

# Set up the repository
mkdir -p "$CVSROOT"
cvs init

# Set up the module
mkdir -p "$WORKINGDIR"
(
    cd "$WORKINGDIR"
    cvs import -m "Initial import" wd vendor-tag release-tag
)

rm -rf "$WORKINGDIR"
cvs co wd

# Add a dummy file to the module, with some tags
(
    cd "$WORKINGDIR"

    echo "A test of multiple tags" > tag-testing

    cvs add tag-testing

    cvs commit -m "Initial file"

    cvs tag -c tag1

    cvs tag -c tag2

    echo "A test of a long tag" >> tag-testing

    cvs commit -m "Updated"

    cvs tag -c very_long_tag_name_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


    for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16; do
        cvs tag -b branch$i
        cvs up -Pd -r branch$i
        echo "touch $i" >> tag-testing
        cvs commit -m"touch$i"
    done
)
