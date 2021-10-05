class Api::V0::UsersController < ApplicationController

    def login
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            token = encode_token({user_id: @user.id})
            render json: { auth_token: token, message: 'user authenticated' }
        else
            render json: {error: "Invalid user credentials"}
        end
    end

    def auto_login
        render json: @user
    end

    private

    def user_params
        params.permit(:email, :password)
    end
end