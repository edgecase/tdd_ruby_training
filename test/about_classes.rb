require 'code_mash'

class AboutClasses < CodeMash::Koan
  class Dice
    def initialize
      @top = 1
    end
    def top
      @top
    end
  end

  def test_xxx
    # The muse died here
  end
end
