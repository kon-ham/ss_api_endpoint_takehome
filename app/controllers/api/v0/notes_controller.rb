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

    def update
        note = Note.find(params[:id])
        note.update(note: params[:attributes][:note])
        render json: NoteSerializer.new(note), status: :ok
    end

    def destroy
        note = Note.find(params[:id])
        note.destroy
        render json: { "data": { "message": "assessment note deleted" } }
    rescue
        render json: { message: "Note not found" }, status: :not_found
    end
end