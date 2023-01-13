class RecipesController < ApplicationController
    skip_before_action :authorized, only: :create
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

def index
recipes = Recipe.all
render json: recipes, include: :user

end

    def create
        current_user = User.find_by(id: session[:user_id])
        if current_user
            recipe = current_user.recipes.create(recipe_params)
        
            if recipe.valid?
                render json: recipe, include: :user, status: :created
            else
                render json: { errors: [recipe.errors.full_messages] }, status: :unprocessable_entity
            end
        else
            render json: {errors: ["Not Authorized"]}, status: :unauthorized
        end
      
    end
    # def create
    
    #     recipe = User.create(recipe_params)
    #     if recipe.valid?
    #       session[:user_id] = user.id
    #       render json: recipe, status: :created
    #     else
    #       render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
    #     end
    #   end
    
    # def show
    #     # current_user = User.find_by(id: session[:user_id])
    #     recipe = Recipe.find_by(id: session[:user_id])
    #     if recipe
        
    #       render json: recipe
    #     else
    #       render json: { error: "Not authorized" }, status: :unauthorized
    #     end
    #   end
  
    private

    def render_unprocessable_entity_response(invalid)
        render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
      end

    def recipe_params
      params.permit(:title, :instructions, :minutes_to_complete)
    end
end

