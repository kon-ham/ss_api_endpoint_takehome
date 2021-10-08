require 'rails_helper'

RSpec.describe 'Teams' do
    before :each do
        @user = User.create!(email: 'johnhenry@trains.edu', password: "driveSteel")
        post '/api/v0/login', params: { email: @user.email, password: @user.password }
        json_object = JSON.parse(response.body, {:symbolize_names => true} )
        @tournament = FactoryBot.create(:tournament)
        @team = FactoryBot.create(:team, tournament: @tournament)
        @player = FactoryBot.create(:player, team: @team)
        @headers = {
            'Authorization': json_object[:auth_token]
        }
        @assessment = @user.assessments.create!(
            rating: 3,
            tournament_id: @tournament.id,
            player_id: @player.id
        )
    end

    describe 'Happy Path - GET /teams/{:team_id}' do
        it 'can successfully reach the GET /teams/{:team_id} with include players params' do
            get "/api/v0/teams/#{@team.id}", headers: @headers, params: { include: "players" }

            json_response = JSON.parse(response.body, symbolize_names: true )

            expect(response).to be_successful

            expect(json_response.keys.count).to eq(2)
            expect(json_response).to have_key(:data)
            expect(json_response).to have_key(:included)

            expect(json_response[:data].keys.count).to eq(4)
            expect(json_response[:data]).to have_key(:id)
            expect(json_response[:data]).to have_key(:type)
            expect(json_response[:data]).to have_key(:attributes)
            expect(json_response[:data]).to have_key(:relationships)

            expect(json_response[:data][:attributes].keys.count).to eq(2)
            expect(json_response[:data][:attributes]).to have_key(:name)
            expect(json_response[:data][:attributes]).to have_key(:age_group)

            expect(json_response[:data][:relationships].keys.count).to eq(1)
            expect(json_response[:data][:relationships]).to have_key(:players)
            
            expect(json_response[:data][:relationships][:players].keys.count).to eq(1)
            expect(json_response[:data][:relationships][:players]).to have_key(:data)

            expect(json_response[:data][:relationships][:players][:data].first.keys.count).to eq(2)
            expect(json_response[:data][:relationships][:players][:data].first).to have_key(:id)
            expect(json_response[:data][:relationships][:players][:data].first).to have_key(:type)

            expect(json_response[:included].first.keys.count).to eq(3)
            expect(json_response[:included].first).to have_key(:id)
            expect(json_response[:included].first).to have_key(:type)
            expect(json_response[:included].first).to have_key(:attributes)

            expect(json_response[:included].first[:attributes].keys.count).to eq(8)
            expect(json_response[:included].first[:attributes]).to have_key(:first_name)
            expect(json_response[:included].first[:attributes]).to have_key(:last_name)
            expect(json_response[:included].first[:attributes]).to have_key(:height)
            expect(json_response[:included].first[:attributes]).to have_key(:weight)
            expect(json_response[:included].first[:attributes]).to have_key(:graduation_year)
            expect(json_response[:included].first[:attributes]).to have_key(:position)
            expect(json_response[:included].first[:attributes]).to have_key(:birthday)
            expect(json_response[:included].first[:attributes]).to have_key(:recruit)
        end
    end

    describe 'Happy Path - GET /teams/{:team_id}' do
        it 'can successfully reach the GET /teams/{:team_id} with out include players params' do
            get "/api/v0/teams/#{@team.id}", headers: @headers

            json_response = JSON.parse(response.body, symbolize_names: true )

            expect(response).to be_successful

            expect(json_response.keys.count).to eq(1)
            expect(json_response).to have_key(:data)

            expect(json_response[:data].keys.count).to eq(4)
            expect(json_response[:data]).to have_key(:id)
            expect(json_response[:data]).to have_key(:type)
            expect(json_response[:data]).to have_key(:attributes)
            expect(json_response[:data]).to have_key(:relationships)

            expect(json_response[:data][:attributes].keys.count).to eq(2)
            expect(json_response[:data][:attributes]).to have_key(:name)
            expect(json_response[:data][:attributes]).to have_key(:age_group)

            expect(json_response[:data][:relationships]).to have_key(:players)
            expect(json_response[:data][:relationships][:players].keys.count).to eq(1)
            expect(json_response[:data][:relationships][:players]).to have_key(:data)

            expect(json_response[:data][:relationships][:players][:data].first.keys.count).to eq(2)
            expect(json_response[:data][:relationships][:players][:data].first).to have_key(:id)
            expect(json_response[:data][:relationships][:players][:data].first).to have_key(:type)
        end
    end
end