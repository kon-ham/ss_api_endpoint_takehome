require 'rails_helper'

RSpec.describe 'User Login' do
    before :all do
        @user = User.create(
            email: 'jingleheimerschmitt@jacob.com',
            password: 'asdf1234'
        )

        @body = {
            email: 'jingleheimerschmitt@jacob.com',
            password: 'asdf1234'
        }
    end

    describe 'POST /login' do
        it 'the /login exists' do
            post '/api/v0/login', params: @body
            expect(response).to be_successful
            expect(response.status).to eq(200)
        end
    end
end