require 'rails_helper'

RSpec.describe 'User Login' do
    before :all do
        @user = User.create(email: 'johnnyappleseed@seed.com', password: "lmaolol")
    end
    describe 'POST /login' do
        it 'the /login endpoint exists' do
            post '/api/v0/login', params: { email: @user.email, password: @user.password }
            expect(response).to be_successful
            expect(response.status).to eq(200)
        end
    end
end
