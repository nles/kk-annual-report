#!/bin/bash
source /usr/local/rvm/scripts/rvm
bundle exec middleman build
cp -a /var/www/html/ /home/www-admin/build_backups/html_`date +%s`
rm -rf /var/www/html/!(content|site)
mv ./build/* /var/www/html/
rm -rf ./build/
