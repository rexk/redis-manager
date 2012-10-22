#!/bin/usr/env ruby
require File.join(File.dirname(__FILE__), 'manager/redismanager')

rm = RedisManager.new
rm.run