#!/bin/sh

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
sudo cp index.html /srv/http/
