class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all
  end

  def articles
    @category = Category.find(params[:id])
    @articles = @category.articles.where(status: 'public').or(@category.articles.where(user: current_user, status: 'draft')).where.not(status: 'archived')
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "Category created successfully."
    else
      render :new , status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path, notice: "Category updated successfully."
    else
      render :edit , status: :unprocessable_entity
    end
  end

  private
  def category_params
    params.require(:category).permit(:title)
  end
end
