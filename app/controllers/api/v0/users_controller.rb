class Api::V0::UsersController < ApplicationController
    def login
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            token = encode_token({user_id: @user.id})
            render json: { auth_token: token, message: 'user authenticated' }
        else
            render json: { error: "Invalid user credentials" }, status: :unauthorized
        end
    end
end