class Api::V0::AssessmentsController < ApplicationController
    before_action :authorized

    def show
        assessment = Assessment.find(params[:id])
        if params.include?("include")
            render json: AssessmentSerializer.new(assessment, include: ['notes']),
            status: 200
        elsif params.include?("include") == false
            render json: AssessmentSerializer.new(assessment), status: 200
        end
    end

    def create
        attributes = params[:attributes]
        assessment = @user.assessments.create!(
            rating: attributes[:rating],
            tournament_id: attributes[:tournament_id],
            player_id: attributes[:player_id]
        )
        assessment.notes.create(
            user_id: @user.id,
            note: attributes["assessment_notes_attributes"].last["note"]
        )
        if params.include?("include")
            render json: AssessmentSerializer.new(assessment, include: ['notes']),
            status: 200
        elsif params.include?("include") == false
            render json: AssessmentSerializer.new(assessment), status: 200
        end
    end

    def destroy
        assessment = Assessment.find(params[:id])
        assessment.destroy
        render json: { "data": {
                            message: 'assessment and notes deleted'
            }
        }
    rescue
        render json: 'Assessment not found'
    end

    private
    def assessment_params
        params.permit(:assessment).require(:user_id, :tournament_id, :player_id)
    end
end