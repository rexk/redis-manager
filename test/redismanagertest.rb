require File.join(File.dirname(__FILE__), '../manager/redisnode')
require File.join(File.dirname(__FILE__), '../manager/rediscommand')
require File.join(File.dirname(__FILE__), '../manager/startcommand')
require File.join(File.dirname(__FILE__), '../manager/redismanager')

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