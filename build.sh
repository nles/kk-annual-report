#!/bin/bash
if [ -f /usr/local/rvm/scripts/rvm ]; then
  source /usr/local/rvm/scripts/rvm
fi
bundle exec middleman build
cp -a /var/www/kirbys/koodiketo /var/www/kkmm/build_backups/html_`date +%s`
#rm -rf /var/www/kirbys/koodiketo/!(content|site)
find /var/www/kirbys/koodiketo/. -maxdepth 1 ! -name 'content' ! -name 'site' ! -name '.*' | xargs rm -rf
mv ./build/* ./build/.* /var/www/kirbys/koodiketo
rm -rf ./build/
