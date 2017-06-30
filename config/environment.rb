#environment file is where we require all to use the lib folder 

require 'bundler'

Bundler.require
require 'open-uri'

require_all './lib'

