require 'code_mash'

class AboutNil < CodeMash::Koan
  def test_nil_is_an_object
    assert nil.is_a?(Object), "Unlike NULL in other languages"
  end

  def test_you_dont_get_null_pointer_errors_when_calling_methods_on_nil
    exception = assert_raise(___) do
      nil.some_method_nil_doesnt_know_about
    end
    assert_match /__/, exception.message
  end

  def test_nil_has_a_few_methods_defined_on_it
    assert_equal __, nil.nil?
    assert_equal __, nil.to_s
    assert_equal __, nil.inspect

    # THINK ABOUT IT:
    #
    # Is it better to use
    #    obj.nil?
    # or
    #    obj == nil
    # Why?
  end

end
