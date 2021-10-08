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

            expect(response).to be_successful
        end
    end
end