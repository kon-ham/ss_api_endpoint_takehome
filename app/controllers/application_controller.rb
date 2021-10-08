class ApplicationController < ActionController::API

    # take payload and encode to JWT standards
    # would need to utilize an ENV variable for
    # production code
    def encode_token(payload)
        JWT.encode(payload, 's3cr3t')
    end

    # defines the header as Authorization and is
    # the header under which the JWT token is passed
    # through for authentication
    def auth_header
        # { Authorization: 'Bearer <token>' }
        request.headers['Authorization']
    end

    # translates the encrypted into useful human readable language
    # else returns nil for decode error. Lines 26-28 were not tested
    # due to limit of author's capability. Definitely an area for improvement
    def decoded_token
        if auth_header
            # token = auth_header.split(' ')[1]
        # header: { 'Authorization': 'Bearer <token>' }
            begin
                JWT.decode(auth_header, 's3cr3t', true, algorithm: 'HS256')
            rescue JWT::DecodeError
                nil
            end
        end
    end

    # if decoded properly, we use the translated human readable language
    # into finding the User by :user_id
    def logged_in_user
        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    # we check to see if a user is logged in
    def logged_in?
        !!logged_in_user
    end

    # this is the method we call on other controllers to certify the user has proper credentials
    # otherwise returns 'invalid user credentials' error
    def authorized
        render json: { message: 'Invalid user credentials' }, status: :unauthorized unless logged_in?
    end
end