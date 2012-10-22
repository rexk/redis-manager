
require 'rubygems'
require 'json'
require 'startcommand'

class Startcommandtest < Test::Unit::TestCase
  def test_help
    conf = "redis.conf"
    nodelist = "redisnodes.json"
    sc = StartCommand.new
    args = [ conf, nodelist] 
    sc.setArgs(nil)
    sc.execute()
  end
  
  def test_execute
    conf = "redis.conf"
    nodelist = "redisnodes.json"
    sc = StartCommand.new
    args = [ conf, nodelist] 
    sc.setArgs(args)
    sc.execute()
  end
end