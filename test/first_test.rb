require 'test/unit'

def __
  "FILL ME IN"
end

class TestSomething < Test::Unit::TestCase
  def test_assert
    assert true
    assert_equal 1, 1
    assert_equal 1, 1.0
  end
end

CodeMash = Test::Unit

class ArrayTest < CodeMash::TestCase
  def test_food
    food = [:peanut, :button, :and, :jelly]
    assert_equal __, food[0]
    assert_equal __, food.size
  end

  def test_food_with_numbers
    food = [:peanut, :button, :and, :jelly, 1, nil]
    assert_equal __, food.size
  end
end
