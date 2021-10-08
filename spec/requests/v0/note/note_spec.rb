require 'rails_helper' 

RSpec.describe 'Players' do
    before :each do
        @user = User.create!(email: 'harrypotter@hogwarts.edu', password: "wingardiumleviosa")
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

    describe 'Happy Path - POST /notes' do
        it 'can successfully reach the POST /notes endpoint and create a note' do
            body = {
                "type": "assessment_notes",
                "attributes": {
                    "note": "Slytherine Seeker. Father was once a Death Eater.",
                    "assessment_id": @assessment.id
                }
            }
            post '/api/v0/notes', headers: @headers, params: body

            json_response = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful
            expect(response.status).to eq(200)
            expect(json_response.count).to eq(1)
            expect(json_response).to have_key(:data)
            expect(json_response[:data].count).to eq(3)
            expect(json_response[:data]).to have_key(:id)
            expect(json_response[:data]).to have_key(:type)
            expect(json_response[:data]).to have_key(:id)
            expect(json_response[:data][:attributes].count).to eq(5)
            expect(json_response[:data][:attributes]).to have_key(:note)
            expect(json_response[:data][:attributes]).to have_key(:user_id)
            expect(json_response[:data][:attributes]).to have_key(:assessment_id)
            expect(json_response[:data][:attributes]).to have_key(:created_at)
            expect(json_response[:data][:attributes]).to have_key(:updated_at)
        end
    end
end