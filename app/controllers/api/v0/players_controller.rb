class Api::V0::PlayersController < ApplicationController
    before_action :authorized

    def index
        players = Player.all
        render json: PlayerSerializer.new(players)
    end
end