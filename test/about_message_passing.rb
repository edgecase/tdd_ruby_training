require 'code_mash'

class AboutMessagePassing < CodeMash::Koan
  
  class MessageCatcher
    def caught?
      true
    end
  end
    
  # In Ruby, we don't call methods that are
  # predefined, we send objects messages
  def test_methods_can_be_called_directly
    mc = MessageCatcher.new
    
    assert mc.caught?    
  end
  
  def test_methods_can_be_invoked_by_sending_the_message
    mc = MessageCatcher.new
    
    assert mc.send(:caught?)
  end
  
  def test_methods_can_be_invoked_more_dynamically
    mc = MessageCatcher.new
    
    assert mc.send("caught?")
    assert mc.send("caught" + "?")
    assert mc.send("CAUGHT".downcase + "?")
  end
  
  respond_to?
  eval
  instance_eval
  method_missing
  
end