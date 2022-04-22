class RecipesController < ApplicationController
    before_action :authorize

    def index
        user = User.find_by_id(session[:user_id])
        render json: Recipe.all, include: ['user'], status: :created
    end

    def create
        user = User.find_by_id(session[:user_id])
        recipe = user.recipes.create!(recipe_params)
        render json: recipe, status: :created #201
    end

    private

    def authorize
        return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
    end
    
    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
