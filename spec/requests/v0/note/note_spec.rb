require 'rails_helper' 

RSpec.describe 'Notes' do
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
                "data": {
                    "type": "assessment_notes",
                    "attributes": {
                        "note": "Slytherine Seeker. Father was once a Death Eater.",
                        "assessment_id": @assessment.id
                    }
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

    describe 'Happy Path - PATCH /notes' do
        it 'can successfully reach the PATCH /notes endpoint and update a note' do
            # recreating the POST route to simulate POST and PATCH of a note in a
            # single block
            before_patch_body = {
                "data": {
                    "type": "assessment_notes",
                    "attributes": {
                        "note": "Slytherine Seeker. Father was once a Death Eater.",
                        "assessment_id": @assessment.id
                    }
                }
            }

            # now a new note should have been created
            post '/api/v0/notes', headers: @headers, params: before_patch_body

            json_response = JSON.parse(response.body, symbolize_names: true)

            #grabbing note_id from the POST note
            note_id = json_response[:data][:id]

            # ensure that my data is still the same
            expect(json_response[:data][:attributes]).to have_key(:note)
            expect(json_response[:data][:attributes][:note]).to eq("Slytherine Seeker. Father was once a Death Eater.")

            # this is where we now test for PATCH capability
            after_patch_body = {
                "data": {
                    "type": "assessment_notes",
                    "attributes": {
                        "note": "Gryffindor Seeker. The Boy Who Lived",
                        "assessment_id": @assessment.id
                    }
                }
            }

            patch "/api/v0/notes/#{note_id}", headers: @headers, params: after_patch_body

            # overwriting json_response variable to reflect the PATCH data change
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

            # data change is reflected
            expect(json_response[:data][:attributes][:note]).to eq("Gryffindor Seeker. The Boy Who Lived")
            expect(json_response[:data][:attributes]).to have_key(:user_id)
            expect(json_response[:data][:attributes]).to have_key(:assessment_id)
            expect(json_response[:data][:attributes]).to have_key(:created_at)
            expect(json_response[:data][:attributes]).to have_key(:updated_at)
        end
    end

    describe 'Happy Path - DELETE /notes/{:note_id}' do
        it 'can successfully reach the endpoint and delete a given note' do
            # recreating the POST route to simulate POST and DELETE of a note in a
            # single block
            before_delete_body = {
                "data": {
                    "type": "assessment_notes",
                    "attributes": {
                        "note": "Slytherine Seeker. Father was once a Death Eater.",
                        "assessment_id": @assessment.id
                    }
                }
            }
            # now a new note should have been created
            post '/api/v0/notes', headers: @headers, params: before_delete_body

            # testing that we have one note in our assessment
            expect(@assessment.notes.all.count).to eq(1)
            json_response = JSON.parse(response.body, symbolize_names: true)

            #grabbing note_id from the POST note
            note_id = json_response[:data][:id]

            delete "/api/v0/notes/#{note_id}", headers: @headers

            # overwriting json_response variable to reflect the PATCH data change
            json_response = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful
            expect(json_response[:data][:message]).to eq("assessment note deleted")

            # now testing that we have zero notes
            expect(@assessment.notes.all.count).to eq(0)
        end
    end

    describe 'Sad Path - DELETE /notes/{:note_id}' do
        it 'can return an error message when deleting a note that does not exist' do
            delete '/api/v0/notes/9000', headers: @headers

            json_response = JSON.parse(response.body, symbolize_names: true)

            expect(response).to_not be_successful
            expect(response.code).to eq("404")
            expect(json_response[:message]).to eq("Note not found")
        end
    end
end