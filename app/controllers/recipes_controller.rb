class RecipesController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]
  before_action :check_user, :only => [:edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to root_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :tagline, :link, :image, :user)
  end

  def check_user
    @recipe = Recipe.find(params[:id])

    if current_user != @recipe.user
      redirect_to root_path, :notice => "You are not authorized to complete this action"
    end
  end
end
