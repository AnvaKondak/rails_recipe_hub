class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  #make sure it is the correct user for only the pages that want to edit, update and destroy. 
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all
  end

  def pubrecipes
    @recipes = Recipe.all
  end 

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = current_user.recipes.build
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = current_user.recipes.build(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:recipe_name, :attachment, :ingredients, :instructions, :isPublic, :user_id, :image)
    end

    def correct_user 
      @recipe = current_user.recipes.find_by(id: params[:id])
      #if recipe id doesnt equal current user id, it will be NIL. 
      redirect_to recipes_path, notice: "Not authorized to edit this recipe" if @recipe.nil?
    end
end
