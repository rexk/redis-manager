Redis Manager
=============
Redis Management tool written in ruby.

Currently, it supports command stop / start.

start / stop command supports starting / stopping multiple Redis instances in one command 

System Requirement
------------------
* Redis Version : v2.6.0
* OS : Ubuntu v12.01 

Installation
------------------
### Ruby Installation
	sudo apt-get install ruby1.9.1
	sudo apt-get install ruby1.9.1-dev

### Ruby JSON
	sudo gem install json
	
### Redis Manager Installation
In order to download project, execute following command
	git clone git://github.com/RexK/redis-manager.git

**Node that the project must be placed at a root folder of redis. this can be achieved by moving every files in the project into the root folder of the Redis
	 
Usage
-----
### start
	ruby rmexec.rb start <path/to/redis.config> <path/to/nodelist>
or
	
	./rmexec.rb start <path/to/redis.config> <path/to/nodelist>
**Note that the mode of rmexec must be executable in order to run command with ./ notation
### stop
	ruby rmexec.rb stop <path/to/pidfile.json>
or

	./rmexec.rb stop <path/to/pidfile.json>
	
Configuration Files
### redis.conf
A conventional redis file

### nodelist
It is a JSON file containing list of nodes in following format.
	
	[
		// Array of node to be initialized
		{"port":9832,"node_number":2},
		{"port":9831,"node_number":1},
		{"slaveof":"123.0.0.1:9082","port":9833,"node_number":4}
	]

### pidfile.json
It is a JSON file containing list of pidfiles for each node number
	
	{
		// node_number : pid path
	 	"1": "/Volumes/RexWorkspace/redis/redis-2.6.0-rc8/node001.pid",
		"2": "/Volumes/RexWorkspace/redis/redis-2.6.0-rc8/node002.pid",
		"4": "/Volumes/RexWorkspace/redis/redis-2.6.0-rc8/node004.pid"
	}
