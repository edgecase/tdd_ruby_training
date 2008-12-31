#!/usr/bin/env ruby
# -*- ruby -*-

require 'test/unit/assertions'

module CodeMash
  class Accumulator
    attr_reader :failure, :failed_test

    def initialize
      @pass_count = 0
      @failure = nil
      @failed_test = nil
    end

    def accumulate(test)
      if test.passed?
        @pass_count += 1
        puts "  #{test.name} has expanded your awareness."
      else
        puts "  #{test.name} has troubled your karma."
        @failed_test = test
        @failure = test.failure
        throw :code_mash_exit
      end
    end

    def failed?
      ! @failure.nil?
    end

    def report
      if failed?
        puts
        puts "You have not yet reached enlightenment ..."
        puts failure.message
        puts
        puts "Please meditate on the following code:"
        puts find_interesting_lines(failure.backtrace)
        puts
      end
      say_something_zenlike
    end

    def find_interesting_lines(backtrace)
      backtrace.reject { |line|
        line =~ /test\/unit\/|code_mash\.rb/
      }
    end

    # Hat's tip to Ara T. Howard for the zen statements from his
    # metakoans Ruby Quiz (http://rubyquiz.com/quiz67.html)
    def say_something_zenlike
      puts
      if !failed?
        puts "Mountains are again merely mountains"
      else
        case @pass_count
        when 0
          puts "mountains are merely mountains"
        when 1, 2
          puts "learn the rules so you know how to break them properly"
        when 3, 4
          puts "remember that silence is sometimes the best answer"
        when 5, 6
          puts "sleep is the best meditation"
        when 7, 8
          puts "when you lose, don't lose the lesson"
        else
          puts "things are not what they appear to be: nor are they otherwise"
        end
      end
    end
  end      

  class Koan
    include Test::Unit::Assertions

    attr_reader :name, :failure

    def initialize(name)
      @name = name
      @failure = nil
    end

    def passed?
      @failure.nil?
    end

    def failed(failure)
      @failure = failure
    end

    def setup
    end

    def teardown
    end

    def __
      "FILL ME IN"
    end

    # Class methods for the CodeMash test suite.
    class << self
      def inherited(subclass)
        subclasses << subclass
      end

      def method_added(name)
        testmethods << name unless tests_disabled?
      end

      def run_tests(accumulator)
        puts
        puts "Contemplating #{self}"
        testmethods.each do |m|
          self.run_test(m, accumulator)
        end
      end

      def run_test(method, accumulator)
        test = self.new(method)
        test.setup
        begin
          test.send(method)
        rescue StandardError => ex
          test.failed(ex)
        ensure
          begin
            test.teardown
          rescue StandardError => ex
            test.failed(ex) if test.passed?
          end
        end
        accumulator.accumulate(test)
      end

      def end_of_enlightenment
        @tests_disabled = true
      end

      # Lazy initialize list of subclasses
      def subclasses
        @subclasses ||= []
      end

       # Lazy initialize list of test methods.
      def testmethods
        @test_methods ||= []
      end

      def tests_disabled?
        @tests_disabled ||= false
      end

    end
  end
end

END {
  accumulator = CodeMash::Accumulator.new
  catch(:code_mash_exit) {
    CodeMash::Koan.subclasses.each do |sc|
      sc.run_tests(accumulator)
    end
  }
  accumulator.report
}
