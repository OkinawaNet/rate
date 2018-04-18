require 'test_helper'

class DollarRateTest < ActiveSupport::TestCase
  test "current value before and after date" do
    dollar_rate = DollarRate.first_or_create
    assert_changes('dollar_rate.current_value') do
      dollar_rate.update_attributes({:forced_until => dollar_rate.forced_until.advance(years: 10)})
    end
  end

  test "updating from site" do
    dollar_rate = DollarRate.first_or_create
    assert_changes('dollar_rate.value') do
      dollar_rate.update_from_site
    end
  end
end
