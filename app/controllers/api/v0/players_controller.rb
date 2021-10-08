class Api::V0::PlayersController < ApplicationController
    before_action :authorized

    def index
        players = Player.all
        render json: PlayerSerializer.new(players)
    end

    def show
        player = Player.find(params[:id])
        render json: PlayerSerializer.new(player)
    rescue
        render json: { message: 'Invalid player request' }, status: 404
    end
end