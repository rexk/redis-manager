require 'rubygems'
require 'json'
require 'manager/rediscommand'
require 'manager/redisnode'
require 'open3'

# Command for Start
class StartCommand < RedisCommand
  private
  
  def prepare?
    if ( @args.nil? || @args.length == 0)
      return false
    end
    
    @conf = @args[0]
    hashed = JSON.parse( File.read( @args[1] ) )
    @nodelist = Array.new
    
    hashed.each {
      |value| 
      @nodelist.push(RedisNode.from_hash(value))
    }
    
    if ( @nodelist.nil?)
      raise "Invalid JSON format"
    end
    @pidfiles = Hash.new
    return true
  end
  
  public
  
  def initialize()
    super("start")
  end
  
  def setArgs(args)
    @args = args
  end
  
  
  # Executing redis-server start up 
  def execute
    if prepare?
      Dir.chdir(Dir.pwd)
      @nodelist.each {
        |node|
        command = getcommand(@conf, node)
        #p command
        stdin, stdout, stderr = Open3.popen3(command)
      }
      f = File.new('pidfiles.json', "w+")
      f.write(JSON.pretty_generate(@pidfiles))
      f.close
    else
      describe()
    end
  end
  
  def getcommand(conf, node)
    command = "./src/redis-server #{conf} "
    params = "--daemonize yes --port #{node.port} --pidfile #{Dir.pwd + '/' + node.pidfile}"
    if node.master?
      params += " --slaveof #{node.slaveof['host']} #{node.slaveof['port']}"
    end
    
    if ( @pidfiles.nil? )
      @pidfiles = Hash.new
    end
    @pidfiles[node.node_number] = Dir.pwd + '/' + node.pidfile
    return command + params
  end
  
  def describe
    return "start <path/to/redis.config> <path/to/nodelist>"
  end
  
end