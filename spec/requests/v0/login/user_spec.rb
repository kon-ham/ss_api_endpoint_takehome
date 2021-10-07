require 'rails_helper'

RSpec.describe 'User Login' do
    before :all do
        @user = User.create(email: 'johnnyappleseed@seed.com', password: "lmaolol")
    end
    describe 'Happy Path - POST /login' do
        it 'can reach the /login endpoint' do
            post '/api/v0/login', params: { email: @user.email, password: @user.password }
            expect(response).to be_successful
            expect(response.status).to eq(200)
        end
    end
    
    describe 'Sad Path - POST /login' do
        it 'returns an error for incorrect password' do
            post '/api/v0/login', params: { email: @user.email, password: 'wrongpassword' }
            expect(response).to_not be_successful
            expect(response.status).to eq(401)

            # created variable to parse and test response message
            json_response = JSON.parse(response.body, symbolize_names: true)
            expect(json_response[:error]).to eq('Invalid user credentials')
        end

        it 'returns an error for incorrect email' do
            post '/api/v0/login', params: { email: 'userdoesntexist@fake.com', password: @user.password }
            expect(response).to_not be_successful
            expect(response.status).to eq(401)

            # created variable to parse and test response message
            json_response = JSON.parse(response.body, symbolize_names: true)
            expect(json_response[:error]).to eq('Invalid user credentials')
        end
    end
end
