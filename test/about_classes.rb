require 'code_mash'

class AboutClasses < CodeMash::Koan
  class Dog
  end

  def test_instances_of_classes_can_be_created_with_new
    fido = Dog.new
    assert_equal __, fido.class
  end

  # ------------------------------------------------------------------

  class Dog2
    def set_name(a_name)
      @name = a_name
    end
  end

  def test_instance_variables_can_be_set_by_assigning_to_them
    fido = Dog2.new
    assert_equal __, fido.instance_variables

    fido.set_name("Fido")
    assert_equal __, fido.instance_variables
  end

  def test_instance_variables_cannot_be_accessed_outside_the_class
    fido = Dog2.new
    fido.set_name("Fido")

    assert_raise(___) do
      fido.name
    end

    assert_raise(___) do
      eval "fido.@name"
    end

  end

end
