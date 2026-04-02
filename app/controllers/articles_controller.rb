class ArticlesController < ApplicationController
  before_action :authenticate_user!
  def index
    @categories = Category.all
    @articles = Article.where(status: 'public').or(Article.where(user: current_user, status: 'draft')).where.not(status: 'archived')
  end

  def show
    @article = Article.find(params[:id])
    unless @article.status == 'public' || @article.user == current_user
      redirect_to articles_path, alert: 'Access denied.'
    end
  end

  def category_articles
    @category = Category.find(params[:id])
    @articles = @category.articles.where(status: 'public').or(@category.articles.where(user: current_user, status: 'draft')).where.not(status: 'archived')
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = current_user.articles.find(params[:id])
  end

  def update
    @article = current_user.articles.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :category_id)
    end
end
