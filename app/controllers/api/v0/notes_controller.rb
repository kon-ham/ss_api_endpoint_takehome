class Api::V0::NotesController < ApplicationController
    before_action :authorized
    
    def create
        attributes = params[:attributes]
        assessment = Assessment.find(attributes[:assessment_id])
        note = assessment.notes.create(
            user_id: @user.id,
            note: attributes[:note]
        )
        render json: NoteSerializer.new(note), status: :ok
    end
end