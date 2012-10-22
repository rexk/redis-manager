require 'stopcommand'

class Stopcommandtest < Test::Unit::TestCase
   
  def test_command
    stop = StopCommand.new
    expected = "kill `cat node001.pid`"
    actual = stop.getcommand("node001.pid")
    
    assert_equal(actual, expected, "Does not match")
  end
end