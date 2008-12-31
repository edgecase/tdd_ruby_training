require 'code_mash'

def my_global_method(a,b)
  a + b
end
  
class AboutMethods < CodeMash::Koan

  def test_calling_global_methods
    assert_equal __, my_global_method(2,3)
  end

  def test_calling_global_methods_without_parenthesis
    result = my_global_method 2, 3
    assert_equal __, result
  end

  # (NOTE: Using eval because the above is a SYNTAX error)
  #
  # Ruby doesn't know if you mean:
  #
  #   assert_equal(5, my_global_method(2), 3)
  # or
  #   assert_equal(5, my_global_method(2, 3))
  #
  # Rewrite the eval string to continue.
  #
  def test_sometimes_missing_parenthesis_are_ambiguous
    eval "assert_equal 5, my_global_method 2, 3"
  end


  # NOTE: wrong number of argument is not a SYNTAX error, but a
  # runtime error.
  def test_calling_global_methods_with_wrong_number_of_arguments
    exception = assert_raise(ArgumentError) do
      my_global_method
    end
    assert_equal __, exception.message

    exception = assert_raise(ArgumentError) do
      my_global_method(1,2,3)
    end
    assert_equal __, exception.message
  end

  def my_same_class_method(a, b)
    a * b
  end

  def test_calling_methods_in_same_class
    assert_equal __, my_same_class_method(3,4)
  end

  def test_calling_methods_in_same_class_with_explicit_receiver
    assert_equal __, self.my_same_class_method(3,4)
  end

  def my_private_method
    "a secret"
  end
  private :my_private_method

  def test_calling_private_methods_without_receiver
    assert_equal __, my_private_method
  end

  def test_calling_private_methods_with_an_explicit_receiver
    exception = assert_raise(NoMethodError) do
      self.my_private_method
    end
    assert_match /__/, exception.message
  end

  class Dog
    def name
      "Fido"
    end
  end
  
  def test_calling_instance_methods_in_other_classes
    rover = Dog.new
    assert_equal __, rover.name
  end
end
