require 'rubygems'
require 'json'
require 'rediscommand'
require 'open3'

class StopCommand < RedisCommand
    public
    def initialize()
      super("stop")
    end
    
    def setArgs(args)
      pidpaths = args[0]
      @pidfiles = JSON.parse( File.read(pidpaths) )
    end
    
    def execute
      Dir.chdir(Dir.pwd)
      @pidfiles.each {
        |node_number, pidfile|
        command = getcommand(pidfile)
        #p command
        stdin, stdout, stderr = Open3.popen3(command)
      }
    end
    
    def getcommand(pidfile)
      command = "kill `cat #{pidfile}`"
      return command
    end
    
    def describe
      return "stop <path/to/pidfile.json>"
    end
end