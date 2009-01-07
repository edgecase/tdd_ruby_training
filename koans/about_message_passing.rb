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
    assert mc.send("caught" + __ )    # What do you need to add to the first string?
    assert mc.send("CAUGHT?".__ )      # What would you need to do to the string?
  end
  
  def test_classes_can_be_asked_if_they_know_how_to_respond
    mc = MessageCatcher.new
    
    assert mc.respond_to?(__)
  end
  
  class MessageCatcher
    def add_a_payload(*args)
      return :empty unless args
      args
    end
  end
  
  def test_sending_a_message_with_arguments
    mc = MessageCatcher.new
    
    assert_equal __ , mc.send(:add_a_payload, 3, 4, nil, 6) 
  end

  # ------------------------------------------------------------------

  # If you can send messages then you should be able to catch 

  class MessageCatcher
    def method_missing(method_name, *args)
      if method_name.to_s == 'something'
        self.send('something' + '_else')
      end
    end
    
    def something_else
      :called
    end
  end
  
  def test_using_method_missing_to_intercept_messages
    mc = MessageCatcher.new
    
    assert_equals :called , mc.__  
    assert_equals :called , mc.__ 
  end
  
  def test_using_method_missing_need_to_account_for_all_cases
    mc = MessageCatcher.new
    
    assert_raise(NoMethodError) do
      mc.no_such_method
    end
  end
  
  # ------------------------------------------------------------------

end