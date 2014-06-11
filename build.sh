#!/bin/bash
source /usr/local/rvm/scripts/rvm
bundle exec middleman build
rm -r /var/www/html/*
mv ./build/* /var/www/html/
rm -r ./build/
