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
        note = assessment.notes.create(
            user_id: @user.id,
            note: attributes["assessment_notes_attributes"].last["note"]
        )

        if params.include?("include")
            render json: { 
                id: assessment.id, 
                type: assessment.assessment_type,
                attributes: assessment.attributes,
                relationships: {
                    assessment_notes: {
                        data: [
                            {
                                id: note.id,
                            }
                        ]
                    }
                }
            },
            status: 200
        elsif params.include?("include") == false
            render json: { 
                id: assessment.id, 
                type: assessment.assessment_type,
                attributes: assessment.attributes.to_json,
                relationships: {
                    assessment_notes: {
                        data: assessment.id
                    }
                }
            }, 
            status: 200
        end
    end

    private

    def assessment_params
        params.require(:assessment).permit(:user_id, :tournament_id, :player_id)
    end
end