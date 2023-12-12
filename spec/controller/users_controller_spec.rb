=begin
Author: Hello (Sandipparida282@gmail.com)
users_controller_spec.rb (c) 2023
Desc: description
Created:  2023-12-11T12:53:05.336Z
Modified: !date!
=end

# spec/controllers/users_controller_spec.rb

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end
end
