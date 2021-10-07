require 'rails_helper' 

RSpec.describe 'Assessments' do
    before :all do
        @user = User.create(email: 'johnnyappleseed@seed.com', password: "lmaolol")
        post '/api/v0/login', params: { email: @user.email, password: @user.password }
        json_object = JSON.parse(response.body, {:symbolize_names => true} )

        @headers = {
            'Authorization': json_object[:auth_token]
        }

        @body = {
            "type": "assessments",
            "attributes": {
                "rating": 5,
                "player_id": 1,
                "tournament_id": 1,
                "assessment_type": "tournament",
                    "assessment_notes_attributes": [
                        {
                            "note": "assessment one text"
                        }
                    ]
                }
            }
    end

    describe 'Happy Path - POST /assessments' do
        it 'can reach the /assessments endpoint' do
            post '/api/v0/assessments', headers: @headers
            expect(response).to be_successful
            expect(response.status).to eq(200)
        end
    end
end