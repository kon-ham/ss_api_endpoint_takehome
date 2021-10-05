require 'rails_helper'

RSpec.describe 'User Login' do
    before :each do
        @user = User.create!(
            email: 'jingleheimerschmitt@jacob.com',
            password: 'asdf1234'
        )
    end

#     describe 'POST /login' do
#         it 'the /login endpoint exists' do
#             post '/api/v0/login'
#             expect(response).to be_successful
#             expect(response.status).to eq(204)
#         end
#     end
end
