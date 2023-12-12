require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  require 'test_helper'

  test 'should be valid' do
    user = User.new(name: 'Example', email: 'user@example.com',password: 'password')
    assert user.valid?
  end

end


