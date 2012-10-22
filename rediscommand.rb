#Abstract class for Command line inputs 
class RedisCommand
  def initialize(name)
    @command_name = name
  end
  
  def command_name
    @command_name
  end
  
  # Passing command arguments
  def setArgs(args)
    
  end
  
  # Run and Execute Command
  def execute
    
  end
  
  def describe
  end
end