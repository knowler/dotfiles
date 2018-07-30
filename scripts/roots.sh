#!/bin/bash

# Regolith aka Un-Bedrock
#
# "But what if we need to hand it off to another agency?" No more!
#
# This script converts a Bedrock site to a normal WordPress structure.
# Run it from the root of a Bedrock project.
#
# Created by Nathan Knowler and Daniel Roe

regolith () {

  echo "Converting Bedrock to a normal WordPress file structure..."

  # Get site name
  site=${PWD##*/}

  # Set destination name
  dest=../$site-wordpress

  # Set .env
  env=./.env

  # Copy WordPress
  cp -a ./web/wp $dest

  # Copy app content
  cp -a ./web/app $dest/wp-content

  # Backup current database
  wp db export $dest/$site-backup.sql

  # Change Bedrock URLs
  wp search-replace '/app/' '/wp-content/'
  wp search-replace '\/app\/' '\/wp-content\/'

  # Export DB
  wp db export $dest/$site.sql

  # Restore DB backup
  wp db import $dest/$site-backup.sql

  # Remove DB backup
  rm $dest/$site-backup.sql

  # Create wp-config.php
  cp $dest/wp-config-sample.php $dest/wp-config.php
  dest_config=$dest/wp-config.php

  # Copy over basic WP database settings
  source $env
  sed -i "s/database_name_here/${DB_NAME}/g" $dest_config
  sed -i "s/username_here/${DB_USER}/g" $dest_config
  sed -i "s/password_here/${DB_PASSWORD}/g" $dest_config
  if [ ! -z "$DB_HOST" ]; then
    sed -i "s/localhost/${DB_HOST}/g" $dest_config
  fi

  # Copy over any other .env settings
  for line in $(grep -v '^#' .env | gxargs -d '\n')
  do
    varname=$(echo ${line} | sed -e 's/\(.*\)=.*/\1/g')
    value=$(echo ${line} | sed -e "s/.*\=\('\(.*\)'\$\)\|\(.*\=\(.*\)\$\)/\4/g")
    if [ -z "$value" ]; then
      value=$(echo ${line} | sed -e "s/.*\=\('\(.*\)'\$\)\|\(.*\=\(.*\)\$\)/\2/g")
    fi
    if [ "$varname" != 'WP_SITEURL' ] && [ "$varname" != 'DB_NAME' ] && [ "$varname" != 'DB_USER' ] && [ "$varname" != 'DB_PASSWORD' ] && [ "$varname" != 'DB_HOST' ] && [ "$varname" != 'WP_SITEURL' ]; then
      echo "define('${varname}', '${value}');" >> $dest_config
    fi
  done

  # Compress
  zip -qr $site.zip $dest
  mv $site.zip ..

  # Clean up
  rm -rf $dest

  # Sassiness
  echo "That was *really* easy. Output is zipped in directory above."
}
