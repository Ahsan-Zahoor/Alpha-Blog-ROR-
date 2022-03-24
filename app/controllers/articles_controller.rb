class ArticlesController < ApplicationController
  before_action :set_article, only:[:update]
  # before_action :require_user, except:[:show,:index]
  # before_action :require_same_user,only: [:edit,:update,:destroy]
  def show
    render :json => @article
  end

  def index
    @articles= Article.paginate(page: params[:page], per_page: 4)
    render :json => @articles
  end

  def new
    @article=Article.new
  end

  def edit
    render :json => @article
  end

  def create
    byebug
    @article = Article.new(article_params)
    if @article.save
      render :json => @article
      flash[:notice]="Article was created sucessfully!"
    else
      render :json => {status:"couldnt be created"}
    end
  end
 
  def update
    byebug
   if  @article.update(article_params)
    render :json => @article
   else
    render :json => {status: "Couldnt be updated"}
   end
  end

  def destroy
    # byebug
    if @article.destroy
    # redirect_to articles_path
      render :json => {status:"Deleted"}
    else
      render :json => {status:"Not Deleted"}
    end
  end

  private

  def set_article
    @article=Article.find_by(id: params[:id])
    if @article.present?
      # render :json => {status:"User deleted"}
    else
      render :json => {status:"no Article against this id"}
    end
  end

  def article_params
    params.permit(:title, :description,:user_id)
  end

  def require_same_user
    if current_user!=@article.user && !current_user.admin?
      flash[:alert]="You can only edit or delete your own article"
      redirect_to @article
    end
  end
end