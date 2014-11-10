#!/bin/sh

abort () {
    echo "Aborting..."
    exit 0
}

if [ $# -ne 1 ]; then
    echo "usage: deploy_homepage.sh www_deploy_directory"
    exit 1
else
    echo "Are you sure you want to deploy the homepage to $1? Y/n [n]"
    read ans
    if [ "$ans" = "Y" -o "$ans" = "y" ]; then
        if [ ! -d "$1" ]; then
            echo "The directory $1 does not exist. Create it (and all parents)? Y/n [n]"
            read ans
            if [ "$ans" = "Y" -o "$ans" = "y" ]; then
                echo "Creating $1..."
                mkdir -p "$1"
            else
                abort
            fi
        fi
        echo "Building..."
    else
        abort
    fi
fi

command -v asciidoctor > /dev/null 2>&1
if [ $? -eq 0 ]; then
    ADOC="asciidoctor"
else
    command -v asciidoc > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        ADOC="asciidoc"
    else
        echo >&2 "asciidoctor or asciidoc is required but is not installed. Aborting."
        exit 1
    fi
fi

$ADOC index.adoc
sudo cp -i index.html $1
