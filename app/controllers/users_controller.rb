class UsersController < ApplicationController
before_action :authorize, only: [:show]

    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created #201
    end

    def show
        user = User.find_by_id(session[:user_id])
        render json: user, status: :created #201
    end

    private

    def authorize
        return render json: { errors: "Not authorized" }, status: :unauthorized unless session.include? :user_id
    end
    
    def user_params
        params.permit(:username, :image_url, :bio, :password, :password_confirmation)
    end
end

