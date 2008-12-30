require 'code_mash'

class AboutArrays < CodeMash::Koan
  def test_food
    food = [:peanut, :button, :and, :jelly]
    assert_equal :peanut, food[0]
    assert_equal 4, food.size
  end

  def test_food_with_numbers
    food = [:peanut, :button, :and, :jelly, 1, nil]
    assert_equal 6, food.size
  end
end
