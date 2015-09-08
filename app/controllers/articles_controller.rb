class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def create

    @article = Article.new(article_params)

    if@article.save
      #render success in Jbuilder
    else
      render json: { message: "400 Bad Request" }, status: :bad_request
    end

  end

  def update
    @article = Article.find_by_id(params[:id])

    if @article.nil?
      render json: { message: "Cannot find your article" }, status: :not_found
    else
      @article.update(article_params)
    end

  def show
    @article = Article.find_by_id(params[:id])

    if @post.nil?
      render json: { message: "Cannot find your article" }, status: :not_found
    end

  def destroy
    @article = Article.find_by_id(params[:id])

    if @article.nil?
      render json: { message: "Cannot find your article"}, status: :not_found
    else

      if @article.destroy
        render json: { message "Successfully deleted" }, status: :no_content
      else
        render json: { message: "Unsuccessfully deleted" }, status: :bad_request
      end
    end
  end


end

