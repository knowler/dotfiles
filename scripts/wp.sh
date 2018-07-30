#!/bin/bash

# WordPress Helpers
owp() { open `wp option get home` && clear }
plugins() { cd `wp plugin path` && clear } 
themes() { cd `wp theme path` && clear }
theme() { cd `wp theme path`/`wp option get stylesheet | cut -d/ -f1` && clear }
