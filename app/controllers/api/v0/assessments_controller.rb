class Api::V0::AssessmentsController < ApplicationController
    before_action :authorized

    def create
        # attributes = params[:attributes]
        # @user.assessments.create!(
        #     rating: attributes[:rating],
        #     tournament_id: attributes[:tournament_id],
        #     player_id: attributes[:player_id],
        #     assessment_type: params[:type]
        # )
    end

    private

    def assessment_params
        params.require(:assessment).permit(:user_id, :tournament_id, :player_id)
    end
end