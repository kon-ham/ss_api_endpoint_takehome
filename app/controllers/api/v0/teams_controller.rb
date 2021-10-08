class Api::V0::TeamsController < ApplicationController
    before_action :authorized
    
    def show
        team = Team.find(params[:id])
        if params[:include] == "players"
            render json: TeamSerializer.new(team, include: ['players'])
        else
            render json: TeamSerializer.new(team)
        end
    end
end