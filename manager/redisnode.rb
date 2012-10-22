require 'rubygems'
require 'json'

class RedisNode
=begin
  Public Region
  Methods below this sections are private methods
=end
  public 
  def initialize(node_number, port, slaveof = nil)
    _checkParams(node_number, port, slaveof)
    @node_number = node_number
    @port = port
    @slaveof = nil
    unless slaveof.nil?
      @slaveof = Hash.new
      @slaveof['host'] = slaveof.split(':')[0]
      @slaveof['port'] = slaveof.split(':')[1].to_i
    end
  end

  def self.from_hash(hashed)
    node_number = hashed['node_number']
    port = hashed['port']
    slaveof = hashed['slaveof']
    return RedisNode.new(node_number,port,slaveof)
  end
  # node_number
  def node_number
    @node_number
  end
  
  # port of a node
  def port
    @port
  end
  
  # Checkes if this node is a master node ( i.e it is not a slave node )
  def master?
    return !@slaveof.nil?
  end
  
  #Check if this node has master node appointed
  def slaveof?
    return !@slaveof.nil?
  end
  
  def slaveof
    @slaveof
  end
  
  # Ruby Hash representation of this node
  def to_hash
    thishash = Hash.new()
    thishash['node_number'] = @node_number
    thishash['port'] = @port
    unless @slaveof.nil?
      thishash['slaveof'] = @slaveof['host'] + ":" + @slaveof['port'].to_s
    end
    return thishash
  end
  
  # JSON reporesentation of this redis node
  def to_json
    return to_hash.to_json
  end
  
  def pidfile
    return "node%03d.pid" % @node_number
  end
=begin
  Private Region
  Methods below this sections are private methods
=end
  private 
  #Private method to check whether params are valid
  def _checkParams(node_number, port, slaveof)
    valid = node_number.is_a?(Fixnum) && port.is_a?(Fixnum) && ( slaveof.nil? || slaveof.is_a?(String))
    unless valid
      raise TypeError, "Invalid Params"
    end
  end
  
  
end