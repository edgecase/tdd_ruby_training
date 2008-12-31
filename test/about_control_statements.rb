require 'code_mash'

class AboutControlStatements < CodeMash::Koan

  def test_if_then_else_statements
    if true
      result = :true_value
    else
      result = :false_value
    end
    assert_equal __, result
  end

  def test_if_then_else_statements
    result = :default_value
    if true
      result = :true_value
    end
    assert_equal __, result
  end

  def test_if_statement_modifiers
    result = :default_value
    result = :true_value if true

    assert_equal __, result
  end

  def test_unless_statement
    result = :default_value
    unless false
      result = :false_value
    end
    assert_equal __, result
  end

  def test_unless_statement_modifier
    result = :default_value
    result = :false_value unless false

    assert_equal __, result
  end

  def test_while_statement
    i = 1
    result = 1
    while i <= 10
      result = result * i
      i += 1
    end
    assert_equal __, result
  end

  def test_break_statement
    i = 1
    result = 1
    while true
      break unless i <= 10
      result = result * i
      i += 1
    end
    assert_equal __, result
  end

  def test_next_statement
    i = 0
    result = []
    while i < 10
      i += 1
      next if (i % 2) == 0
      result << i 
    end
    assert_equal __, result
  end

  def test_for_statement
    array = ["fish", "and", "chips"]
    result = []
    for item in array
      result << item.upcase
    end
    assert_equal [__, __, __], result
  end

end
