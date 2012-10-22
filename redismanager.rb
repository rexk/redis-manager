require 'redisnode'
require 'rediscommand'
require 'startcommand'

class RedisManager
  @commandlists
  
  def initialize()
    @commandlists = Hash.new
  end
  
  def addCommand(command)
    unless command.kind_of?(RedisCommand)
      raise TypeError, "Invalid Command"
    end
    @commandlists[command.command_name] = command
  end
  
  def run()
    if ARGV.length == 0
      puts "Registered Command lists"
      counter = 1
      @commandlists.each{
        |key, value|
        puts "#{counter}. #{key}\tUsage #{value.describe}"
        counter += 1
      }
    else
      command = @commandlists[ARGV[0]]
      command.setArgs( ARGV[1..ARGV.length] )
      command.execute
    end
  end
end