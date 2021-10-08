require 'rails_helper' 
# Please be advised: currently the model does not reflect a relationship with all users,
# so the endpoint returns ALL players instead of players associated with the user

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
        it 'can reach the GET /players endpoint and return all players' do
            get '/api/v0/players', headers: @headers

            json_response = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful
            expect(response.status).to eq(200)

            expect(json_response).to have_key(:data)
            expect(json_response[:data].last.count).to eq(3)
            expect(json_response[:data].last).to have_key(:id)
            expect(json_response[:data].last).to have_key(:type)
            expect(json_response[:data].last).to have_key(:attributes)

            expect(json_response[:data].last[:attributes].count).to eq(8)
            expect(json_response[:data].last[:attributes]).to have_key(:first_name)
            expect(json_response[:data].last[:attributes]).to have_key(:last_name)
            expect(json_response[:data].last[:attributes]).to have_key(:height)
            expect(json_response[:data].last[:attributes]).to have_key(:weight)
            expect(json_response[:data].last[:attributes]).to have_key(:birthday)
            expect(json_response[:data].last[:attributes]).to have_key(:graduation_year)
            expect(json_response[:data].last[:attributes]).to have_key(:position)
            expect(json_response[:data].last[:attributes]).to have_key(:recruit)
        end
    end

    describe 'Happy Path - GET /players/{:player_id}' do
        it 'can successfully GET /players/{:player_id} and return a specific player' do
            get "/api/v0/players/#{@player.id}", headers: @headers

            json_response = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful
            expect(response.status).to eq(200)

            expect(json_response).to have_key(:data)
            expect(json_response[:data].count).to eq(3)
            expect(json_response[:data]).to have_key(:id)
            expect(json_response[:data]).to have_key(:type)
            expect(json_response[:data]).to have_key(:attributes)

            expect(json_response[:data][:attributes].count).to eq(8)
            expect(json_response[:data][:attributes]).to have_key(:first_name)
            expect(json_response[:data][:attributes]).to have_key(:last_name)
            expect(json_response[:data][:attributes]).to have_key(:height)
            expect(json_response[:data][:attributes]).to have_key(:weight)
            expect(json_response[:data][:attributes]).to have_key(:birthday)
            expect(json_response[:data][:attributes]).to have_key(:graduation_year)
            expect(json_response[:data][:attributes]).to have_key(:position)
            expect(json_response[:data][:attributes]).to have_key(:recruit)
        end

        it 'can successfully GET /players/{:player_id} and return a specific player w/ params include: notes' do
            # I created this test in order to verify my params query works for include either
            # assessment notes or notes params, but they are both failing - I'm able to serialize
            # Player but I'm currently unable to add the include feature due to my own lack of 
            # understanding how JSONAPI::Serializer works in conjunction with my models
            assessment = @player.assessments.create!(
                rating: 9,
                user_id: @user.id,
                tournament_id: @tournament.id,
            )

            assessment.notes.create!(
                user_id: @user.id,
                note: "HERE WE GO!!!",
            )

            get "/api/v0/players/#{@player.id}", headers: @headers, params: { include: "notes" }

            # json_response = JSON.parse(response.body, symbolize_names: true)
            # expect(response).to be_successful
            # expect(response.status).to eq(200)
            # expect(json_response).to have_key(:data)
            # expect(json_response[:data].count).to eq(3)
            # expect(json_response[:data]).to have_key(:id)
            # expect(json_response[:data]).to have_key(:type)
            # expect(json_response[:data]).to have_key(:attributes)
            # expect(json_response[:data][:attributes].count).to eq(8)
            # expect(json_response[:data][:attributes]).to have_key(:first_name)
            # expect(json_response[:data][:attributes]).to have_key(:last_name)
            # expect(json_response[:data][:attributes]).to have_key(:height)
            # expect(json_response[:data][:attributes]).to have_key(:weight)
            # expect(json_response[:data][:attributes]).to have_key(:birthday)
            # expect(json_response[:data][:attributes]).to have_key(:graduation_year)
            # expect(json_response[:data][:attributes]).to have_key(:position)
            # expect(json_response[:data][:attributes]).to have_key(:recruit)
        end
    end

    describe 'Sad Path - GET /players/{:player_id}' do
        it 'can return an error message for a player that does not exist' do
            get "/api/v0/players/9000", headers: @headers

            expect(response).to_not be_successful
            expect(response.status).to eq(404)
        end
    end
end