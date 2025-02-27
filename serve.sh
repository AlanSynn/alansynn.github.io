#!/bin/bash

# Set Sass environment variables to silence deprecation warnings
export SASS_QUIET=true
export SASS_QUIET_DEPS=true
export SASS_NO_DEPRECATION_WARNING=true

# Run Jekyll with the Sass options and development config
bundle exec jekyll serve --config _config.yml,_config_dev.yml --livereload