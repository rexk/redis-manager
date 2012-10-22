require 'rubygems'
require 'json'
require 'open3'
require File.join(File.dirname(__FILE__), 'rediscommand')

# Reads a pidfiles in json and kill associate processes
class StopCommand < RedisCommand
    private
    def prepare?
      return !@pidfiles.nil?
    end
    
    public
    def initialize()
      super("stop")
    end
    
    def setArgs(args)
      @pidpaths = args[0]
      @pidfiles = JSON.parse( File.read(@pidpaths) )
    end
    
    def execute
      if ( prepare? )
      Dir.chdir(Dir.pwd)
      @pidfiles.each {
        |node_number, pidfile|
        command = getcommand(pidfile)
        #p command
        stdin, stdout, stderr = Open3.popen3(command)
      }
      File.delete(@pidpaths)
      else
        describe()
      end
    end
    
    # returns unix command string
    def getcommand(pidfile)
      command = "kill `cat #{pidfile}`"
      return command
    end
    
    # description method about how to use this command
    def describe
      return "stop <path/to/pidfile.json>"
    end
end