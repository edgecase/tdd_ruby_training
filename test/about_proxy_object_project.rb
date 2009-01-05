require 'code_mash'

class Television
  attr_accessor :channel
  
  def power
    if @power == :on
      @power = :off
    else
      @power = :on
    end
  end
  
  def on?
    @power == :on
  end
end

class Proxy
  def initialize(object)
    @object = object
  end
end

def proxy(object)
  Proxy.new(object)
end

class AboutProxyObjectProject < CodeMash::Koan
  def test_proxy_method_returns_wrapped_object  
    tv = proxy(Television)    
    
    assert tv.instance_of?(Proxy)
  end
  
  def test_methods_still_perform_their_function
    tv = proxy(Television)
    
    tv.channel 10
    tv.power
    
    assert_equal 10, tv.power
    assert tv.on?
  end

  def test_proxy_records_messages
    tv = proxy(Television)
    
    tv.power
    tv.channel 10
    
    assert_equal [:new, :power, :channel] , tv.messages
  end
  
  def test_proxy_handles_invalid_messages
    tv = proxy(Television)
    
    assert_raise(NoMethodError) do
      tv.no_such_method
    end
  end
  
  def test_proxy_reports_methods_have_been_called
    tv = proxy(Television)
    
    tv.power
    tv.power
    
    assert tv.called?(:power)
    assert ! tv.called?(:channel)
  end
  
  def test_proxy_counts_method_calls
    tv = proxy(Television)
    
    tv.power
    tv.power

    assert_equal 2, tv.number_of_times_called(:power)
    assert_equal 1, tv.number_of_times_called(:new)
    assert_equal 0, tv.number_of_times_called(:on?)
  end

end


# Nothing needs to be done with this test
class TelevisionTest < CodeMash::Koan
  def test_it_turns_on
    tv = Television.new
    
    tv.power
    assert tv.on?
  end
  
  def test_it_also_turns_off
    tv = Television.new
    
    tv.power
    tv.power
    
    assert ! tv.on?
  end
  
  def test_edge_case_on_off
    tv = Television.new
    
    tv.power
    tv.power
    tv.power
        
    assert tv.on?
    
    tv.power
    
    assert ! tv.on?
  end
end