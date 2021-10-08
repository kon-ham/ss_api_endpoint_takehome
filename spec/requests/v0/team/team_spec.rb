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
            get "/api/v0/teams/#{@team.id}", headers: @header, params: { include: "players" }

            expect(response).to be_successful
        end
    end
end