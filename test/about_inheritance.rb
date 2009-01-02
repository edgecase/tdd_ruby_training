require 'code_mash'

class AboutInheritance < CodeMash::Koan
  class Dog
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def bark
      "WOOF"
    end
  end

  class Chihuahua < Dog
    def wag
      :happy
    end

    def bark
      "yip"
    end
  end

  def test_subclasses_have_the_parent_as_an_ancestor
    assert_equal __, Chihuahua.ancestors.include?(Dog)
  end

  def test_all_classes_ultimately_inherit_from_object
    assert_equal __, Chihuahua.ancestors.include?(Object)
  end

  def test_subcases_inherit_behavior_from_parent_class
    chico = Chihuahua.new("Chico")
    assert_equal __, chico.name
  end

  def test_subclasses_add_new_behavior
    chico = Chihuahua.new("Chico")
    assert_equal __, chico.wag

    assert_raise(___) do
      fido = Dog.new("Fido")
      fido.wag
    end
  end

  def test_subclasses_can_modify_existing_behavior
    chico = Chihuahua.new("Chico")
    assert_equal __, chico.bark

    fido = Dog.new("Fido")
    assert_equal __, fido.bark
  end

end
