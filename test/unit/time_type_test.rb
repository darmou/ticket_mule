require 'test_helper'

class TimeTypeTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    time_type = TimeType.new
    assert !time_type.valid?
    #puts time_type.errors.full_messages
    assert time_type.errors.invalid?(:name)
  end

  test "should be valid" do
    priority = Factory(:time_type)
    assert time_type.valid?
  end

  test "should be disabled" do
    time_type = Factory(:disabled_time_type)
    assert !time_type.enabled?
  end
end
