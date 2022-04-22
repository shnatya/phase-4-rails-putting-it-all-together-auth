class SessionsController < ApplicationController
before_action :authorize, only: [:destroy]
    def create
        user = User.find_by_username(params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user
        else
            render json: {errors: ["Invalide username or password"]}, status: :unauthorized #401
        end
    end

    def destroy
        user = User.find_by_id(session[:user_id])
        session.delete :user_id
        head :no_content
    end

    private

    def authorize
        return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id #401
    end
end
