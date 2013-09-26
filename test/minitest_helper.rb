require "bundler"
require "simplecov"
SimpleCov.start do
  add_filter "/test/"
  add_filter "/vendor/"
end

Bundler.require

require "minitest"
require "minitest/autorun"
require "minitest/mock"
require "minitest/spec"

require "raphl"

$redis.flushdb

