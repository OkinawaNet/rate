require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get "/admin"
    assert_response :success
  end

  test "should save forced rate" do
    assert_changes('DollarRate.first_or_create.formatted_forced_value') do
      post '/admin/rate_update', params: { rate: { formatted_forced_value: '14,44', forced_until: Time.new, time_difference: '240' } }
    end
  end

  test "should not save forced rate" do
    assert_no_changes('DollarRate.first_or_create.formatted_forced_value') do
      post '/admin/rate_update', params: { rate: { formatted_forced_value: '-14,44', forced_until: Time.new, time_difference: '240' } }
    end

    assert_no_changes('DollarRate.first_or_create.formatted_forced_value') do
      post '/admin/rate_update', params: { rate: { formatted_forced_value: '14,44', forced_until: Time.new.advance(:years => -1), time_difference: '240' } }
    end
  end

end
