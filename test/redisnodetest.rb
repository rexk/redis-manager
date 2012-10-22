require "redisnode"

class Redisnodetest < Test::Unit::TestCase
  def test_toHash
    expected = {
       'node_number' => 2,
       "port" => 9832,
       'slaveof' => "123.12.32.12:9082"
    }
    node = RedisNode.new(2, 9832, "123.12.32.12:9082")
    actual = node.to_hash()
    assert_equal(expected,actual,"Actual hash and expected hash does not match each other")
    
  end
      
  def test_toJson
    expected = {
           'node_number' => 2,
           "port" => 9832,
           'slaveof' => "123.12.32.12:9082"
        }.to_json
    node = RedisNode.new(2, 9832, "123.12.32.12:9082")
    actual = node.to_json()
    assert_equal(expected,actual,"Actual json and expected json does not match each other")
  end
  
  def test_Invalid
    expected = { 
                 "host" => "128.234.12.21",
                 "port" => 9832,
              }.to_json
    
  assert_raise( TypeError ) {
    node = RedisNode.new("128.234.12.21", "9832")
  }
  end
  
  def test_nomaster
    expected = {
               'node_number' => 2,
               "port" => 9832
            }.to_json
    node = RedisNode.new(2, 9832)
    actual = node.to_json()
    assert_equal(expected,actual,"Actual json and expected json does not match each other")
  end
  
  def test_fromHash
    expected = {
           'node_number' => 2,
           "port" => 9832,
           'slaveof' => "123.12.32.12:9082"
        }
        
    actual = RedisNode.from_hash(expected)
    
    assert_equal(expected, actual.to_hash(), "Does not Match")
  end
  
  def test_fromHash_withoutmaster
    expected = {
               'node_number' => 2,
               "port" => 9832
            }
            
    actual = RedisNode.from_hash(expected)
    
    assert_equal(expected, actual.to_hash(), "Does not Match")
  end
    
  def test_pidfile
    hashed = {'node_number' => 2, "port" => 9832}
    node = RedisNode.from_hash(hashed)
    expected = "node002.pid"
    actual = node.pidfile()
    
    assert_equal(expected,actual,"Does not match")
  end
  
end