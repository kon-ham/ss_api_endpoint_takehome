require 'rails_helper' 

RSpec.describe 'Players' do
    before :each do
        @user = User.create!(email: 'johnnyzappleseed@seed.com', password: "yaknowit")
        post '/api/v0/login', params: { email: @user.email, password: @user.password }
        json_object = JSON.parse(response.body, {:symbolize_names => true} )
        @tournament = FactoryBot.create(:tournament)
        @team = FactoryBot.create(:team, tournament: @tournament)
        @player = FactoryBot.create(:player, team: @team)
        @headers = {
            'Authorization': json_object[:auth_token]
        }
    end

    describe 'Happy Path - GET /players' do
        # Please be advised: currently the model does not reflect a relationship with all users,
        # so the endpoint returns ALL players instead of players associated with the user
        it 'can reach the GET /players endpoint and return all players' do
            get '/api/v0/players', headers: @headers

            json_response = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful
            expect(response.status).to eq(200)
        end
    end
end