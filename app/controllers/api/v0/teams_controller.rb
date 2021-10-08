class Api::V0::TeamsController < ApplicationController
    def show
        team = Team.find(params[:id])
        if params[:include] == "players"
            render json: { TeamSerializer.new(team) }
        end
    end
end