require 'mocha_standalone'
require 'mocha/expectation_error'

Mocha::ExpectationErrorFactory.exception_class = MiniTest::Assertion

module Mocha
  module Integration
    module MiniTest

      class AssertionCounter
        def initialize(test_case)
          @test_case = test_case
        end

        def increment
          @test_case.assert(true)
        end
      end

      include Mocha::API

      def before_setup
        mocha_setup
        super
      end

      def before_teardown
        assertion_counter = AssertionCounter.new(self)
        mocha_verify(assertion_counter)
      ensure
        super
      end

      def after_teardown
        super
        mocha_teardown
      end
    end
  end
end

