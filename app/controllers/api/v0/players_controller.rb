class Api::V0::PlayersController < ApplicationController
    before_action :authorized

    def index
        players = Player.all
        render json: PlayerSerializer.new(players),
        status: 200
    end

    def show
        player = Player.find(params[:id])
        # params[:include] for both assessments and notes currently fails - still
        # working out the kinks. 
        if params[:include] == "assessments"
            # render json: PlayerSerializer.new(player, include: ['assessments']),
            # status: 200
        elsif params[:include] == "notes"
            # render json: PlayerSerializer.new(player, include: ['notes']),
            # status: 200
        else
            render json: PlayerSerializer.new(player),
            status: 200
        end
    rescue
        render json: { message: 'Invalid player request' }, status: :not_found
    end
end