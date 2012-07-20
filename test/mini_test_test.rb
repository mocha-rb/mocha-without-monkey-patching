require 'test_helper'

require 'minitest/unit'
require 'minitest/autorun'

require 'mocha/integration/mini_test'

class MiniTestTest < MiniTest::Unit::TestCase
  include Mocha::Integration::MiniTest

  def setup
    if __name__ == "test_mock_object_unexpected_invocation_in_setup"
      mock = mock("not expecting invocation")
      mock.unexpected
    elsif __name__ == "test_mock_object_unsatisfied_expectation_in_setup"
      mock = mock("expecting invocation")
      mock.expects(:expected)
    end
  end

  def teardown
    if __name__ == "test_mock_object_unexpected_invocation_in_teardown"
      mock = mock("not expecting invocation")
      mock.unexpected
    elsif __name__ == "test_mock_object_unsatisfied_expectation_in_teardown"
      mock = mock("expecting invocation")
      mock.expects(:expected)
    end
  end

  def test_mock_object_unexpected_invocation_in_setup
  end

  def test_mock_object_unexpected_invocation_in_teardown
  end

  def test_mock_object_unsatisfied_expectation_in_setup
  end

  def test_mock_object_unsatisfied_expectation_in_teardown
  end

  def test_assertion_satisfied
    assert true
  end

  def test_assertion_unsatisfied
    flunk
  end

  def test_mock_object_unexpected_invocation
    mock = mock("not expecting invocation")
    mock.unexpected
  end

  def test_mock_object_unsatisfied_expectation
    mock = mock("expecting invocation")
    mock.expects(:expected)
  end

  def test_real_object_unexpected_invocation
    object = Object.new
    object.expects(:unexpected).never
    object.unexpected
  end

  def test_real_object_unsatisfied_expectation
    object = Object.new
    object.expects(:expected)
  end
end

