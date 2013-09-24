require 'bundler'
Bundler.require

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "lib")
require 'raphl'

run Raphl::App

