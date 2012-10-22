require 'redisnode'
require 'rediscommand'
require 'startcommand'
require 'redismanager'

class Redismanagertest < Test::Unit::TestCase
  def test_run
    ARGV[0] = 'start'
    ARGV[1] = "redis.conf"
    ARGV[2] = "redisnodes.json"
    
    rm = RedisManager.new
    rm.addCommand(StartCommand.new)
    rm.run()
  end
end