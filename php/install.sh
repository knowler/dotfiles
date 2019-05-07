#!/usr/bin/env bash

COMPOSER_DIR=$HOME/.composer

# Link global Composer dependencies
ln -s composer.json $COMPOSER_DIR/composer.json

# Install
composer -d $COMPOSER_DIR install
