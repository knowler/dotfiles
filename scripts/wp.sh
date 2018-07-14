#!/bin/bash

# WordPress Helpers
owp() { open `wp option get home` }
plugins() { cd `wp plugin path` } 
themes() { cd `wp theme path` }
theme() { cd `wp theme path`/`wp option get stylesheet | cut -d/ -f1` }
