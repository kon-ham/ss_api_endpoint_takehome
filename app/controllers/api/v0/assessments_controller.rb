class Api::V0::AssessmentsController < ApplicationController
    before_action :authorized

    def create
        attributes = params[:attributes]
        assessment = @user.assessments.create!(
            rating: attributes[:rating],
            tournament_id: attributes[:tournament_id],
            player_id: attributes[:player_id],
            assessment_type: params[:type]
        )
        assessment.notes.create(
            user_id: @user.id,
            note: attributes["assessment_notes_attributes"].last["note"]
        )

        if params.include?("include")
            render json: AssessmentSerializer.new(assessment), status: 200
        elsif params.include?("include") == false
            render json: AssessmentSerializer.new(assessment), status: 200
        end
    end

    private

    def assessment_params
        params.require(:assessment).permit(:user_id, :tournament_id, :player_id)
    end
end