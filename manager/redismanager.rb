require File.join(File.dirname(__FILE__), 'redisnode')
require File.join(File.dirname(__FILE__), 'rediscommand')
require File.join(File.dirname(__FILE__), 'startcommand')
require File.join(File.dirname(__FILE__), 'stopcommand')

# Class that manages redis commands 
class RedisManager
  @commandlists
  
  # Initializing of RedisManager
  def initialize()
    @commandlists = Hash.new
    addCommand(StartCommand.new)
    addCommand(StopCommand.new)
  end
  
  # More commands can be added through following method
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
        printf "#{counter}. %-10s Usage: #{value.describe}\n", key
        counter += 1
      }
    else
      command = @commandlists[ARGV[0]]
      command.setArgs( ARGV[1..ARGV.length] )
      command.execute
    end
  end
end