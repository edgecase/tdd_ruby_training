#!/usr/bin/env ruby
# -*- ruby -*-

require 'code_mash'

class AboutAsserts < CodeMash::Koan
  def test_assert
    assert true
    assert_equal 1, 1
    assert_equal 1, 1.0
  end
end

class AboutArrays < CodeMash::Koan
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
