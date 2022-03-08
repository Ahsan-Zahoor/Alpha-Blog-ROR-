class ArticlesController < ApplicationController
  def show
    # byebug
    @article=Article.find(params[:id])
  end

  def index
    @articles= Article.all
  end

  def new
    @article=Article.new
  end

  def edit
    @article=Article.find(params[:id])
  end

  def create
    # just to render what user entered the article
    # render plain: params[:article]
    # to save to the database
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save
      flash[:notice]="Article was created sucessfully!"
      redirect_to @article 
    else
      render 'new'
    end
  end

  def update
    @article =Article.find(params[:id])
   if  @article.update(params.require(:article).permit(:title, :description))
    flash[:notice]="Article was updated successfully"
    redirect_to @article
   else
    render 'edit'
   end
  end

end