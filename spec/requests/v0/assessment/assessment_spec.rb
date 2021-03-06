require 'rails_helper' 

RSpec.describe 'Assessments' do
    before :each do
        @user = User.create!(email: 'johnnyrappleseed@seed.com', password: "lmaolol")
        post '/api/v0/login', params: { email: @user.email, password: @user.password }
        json_object = JSON.parse(response.body, {:symbolize_names => true} )
        @tournament = FactoryBot.create(:tournament)
        @team = FactoryBot.create(:team, tournament: @tournament)
        @player = FactoryBot.create(:player, team: @team)
        @headers = {
            'Authorization': json_object[:auth_token]
        }
        @body = {
        "data": {
            "type": "assessments",
            "attributes": {
                "rating": 5,
                "player_id": @player.id,
                "tournament_id": @tournament.id,
                "assessment_type": "tournament",
                    "assessment_notes_attributes": [
                        {
                            "note": "assessment one text"
                        }
                    ]
                }
            },
        "include": "notes"
        }
    end

    describe 'Happy Path - POST /assessments' do
        it 'can reach the /assessments endpoint /w include param' do
            post '/api/v0/assessments', headers: @headers, params: @body
            json_response = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful
            expect(response.status).to eq(200)

            expect(json_response).to have_key(:data)
            expect(json_response).to have_key(:included)

            expect(json_response[:data].keys.count).to eq(4)
            expect(json_response[:data]).to have_key(:id)
            expect(json_response[:data]).to have_key(:type)
            expect(json_response[:data]).to have_key(:attributes)
            expect(json_response[:data]).to have_key(:relationships)

            expect(json_response[:data][:attributes].keys.count).to eq(7)
            expect(json_response[:data][:attributes]).to have_key(:rating)
            expect(json_response[:data][:attributes]).to have_key(:user_id)
            expect(json_response[:data][:attributes]).to have_key(:player_id)
            expect(json_response[:data][:attributes]).to have_key(:tournament_id)
            expect(json_response[:data][:attributes]).to have_key(:assessment_type)
            expect(json_response[:data][:attributes]).to have_key(:created_at)
            expect(json_response[:data][:attributes]).to have_key(:updated_at)
        end

        it 'can reach the /assessments endpoint without include param' do
            body = {
                "data": {
                    "type": "assessments",
                    "attributes": {
                        "rating": 5,
                        "player_id": @player.id,
                        "tournament_id": @tournament.id,
                        "assessment_type": "tournament",
                            "assessment_notes_attributes": [
                                {
                                    "note": "assessment one text"
                                }
                            ]
                        },
                    }
                }
            post '/api/v0/assessments', headers: @headers, params: body
            json_response = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful
            expect(response.status).to eq(200)

            expect(json_response).to have_key(:data)
            expect(json_response).to_not have_key(:included)

            expect(json_response[:data].keys.count).to eq(4)
            expect(json_response[:data]).to have_key(:id)
            expect(json_response[:data]).to have_key(:type)
            expect(json_response[:data]).to have_key(:attributes)
            expect(json_response[:data]).to have_key(:relationships)

            expect(json_response[:data][:attributes].keys.count).to eq(7)
            expect(json_response[:data][:attributes]).to have_key(:rating)
            expect(json_response[:data][:attributes]).to have_key(:user_id)
            expect(json_response[:data][:attributes]).to have_key(:player_id)
            expect(json_response[:data][:attributes]).to have_key(:tournament_id)
            expect(json_response[:data][:attributes]).to have_key(:assessment_type)
            expect(json_response[:data][:attributes]).to have_key(:created_at)
            expect(json_response[:data][:attributes]).to have_key(:updated_at)
        end
    end

    describe 'Happy Path - GET /assessments/{:id}' do
        it 'can reach the /assessments/{:id} endpoint w/ include param' do
            assessment = @user.assessments.create(
                rating: 5,
                tournament_id: @tournament.id,
                player_id: @player.id
            )
            get "/api/v0/assessments/#{assessment.id}", headers: @headers, params: { include: "notes" }
            json_response = JSON.parse(response.body, symbolize_names: true)
            
            expect(response).to be_successful
            expect(response.status).to eq(200)

            expect(json_response).to have_key(:data)
            expect(json_response).to have_key(:included)

            expect(json_response[:data].keys.count).to eq(4)
            expect(json_response[:data]).to have_key(:id)
            expect(json_response[:data]).to have_key(:type)
            expect(json_response[:data]).to have_key(:attributes)
            expect(json_response[:data]).to have_key(:relationships)

            expect(json_response[:data][:attributes].keys.count).to eq(7)
            expect(json_response[:data][:attributes]).to have_key(:rating)
            expect(json_response[:data][:attributes]).to have_key(:user_id)
            expect(json_response[:data][:attributes]).to have_key(:player_id)
            expect(json_response[:data][:attributes]).to have_key(:tournament_id)
            expect(json_response[:data][:attributes]).to have_key(:assessment_type)
            expect(json_response[:data][:attributes]).to have_key(:created_at)
            expect(json_response[:data][:attributes]).to have_key(:updated_at)
        end

        it 'can reach the /assessments/{:id} endpoint without include param' do
            assessment = @user.assessments.create(
                rating: 5,
                tournament_id: @tournament.id,
                player_id: @player.id
            )
            get "/api/v0/assessments/#{assessment.id}", headers: @headers
            json_response = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful
            expect(response.status).to eq(200)

            expect(json_response).to have_key(:data)
            expect(json_response).to_not have_key(:included)

            expect(json_response[:data].keys.count).to eq(4)
            expect(json_response[:data]).to have_key(:id)
            expect(json_response[:data]).to have_key(:type)
            expect(json_response[:data]).to have_key(:attributes)
            expect(json_response[:data]).to have_key(:relationships)
            
            expect(json_response[:data][:attributes].keys.count).to eq(7)
            expect(json_response[:data][:attributes]).to have_key(:rating)
            expect(json_response[:data][:attributes]).to have_key(:user_id)
            expect(json_response[:data][:attributes]).to have_key(:player_id)
            expect(json_response[:data][:attributes]).to have_key(:tournament_id)
            expect(json_response[:data][:attributes]).to have_key(:assessment_type)
            expect(json_response[:data][:attributes]).to have_key(:created_at)
            expect(json_response[:data][:attributes]).to have_key(:updated_at)
        end
    end

    describe 'Happy Path - DELETE /assessment/{:assessment_id}' do
        it 'can reach the /assessments/{:id} endpoint and delete assessment' do
            assessment = @user.assessments.create(
                rating: 5,
                tournament_id: @tournament.id,
                player_id: @player.id
            )
            delete "/api/v0/assessments/#{assessment.id}", headers: @headers
            json_response = JSON.parse(response.body, symbolize_names: true)

            expect(json_response[:data][:message]).to eq("assessment and notes deleted")
        end
    end

    describe 'Sad Path - DELETE /assessment/{:assessment_id}' do
        it "can return an error message when attempting to delete an assessment that doesn't exist" do
            delete "/api/v0/assessments/9000", headers: @headers

            expect(response.body).to eq("Assessment not found")
        end
    end
end