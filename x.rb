require 'test/unit'

class TestSomething < Test::Unit::TestCase
  def test_assertion
    assert true
  end

  def test_basic_math_facts
    assert 1 == 1
    assert 1 != 2
  end

  def one
    1
  end

  def test_method_calling
    assert one == 1
  end

  def one_equals_one
    1 == 1
  end

  def test_method_return_values
    assert one_equals_one
  end
end
