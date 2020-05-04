#! /usr/bin/env bash

ZIP_PATH=$1
chmod +r $ZIP_PATH
unzip -o $ZIP_PATH -d /tmp/package
cd /tmp/package
make stop run