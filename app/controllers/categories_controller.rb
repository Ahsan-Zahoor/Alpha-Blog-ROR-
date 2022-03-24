class CategoriesController < ApplicationController
  before_action :set_category,only: [:show,:update,:destroy]

  # before_action :require_admin,except: [:index,:show]

  def new
    @category=Category.new
  end

  def create
    @category=Category.new(category_params)
    if @category.save
      render :json => @category
    else
      render :json => {status:"false"}
    end
  end

  def update
    if @category && @category.update(category_params)
      render :json => @category
      flash[:notice]="Your account information was successfully updated"
    else
      render :json => {status:"false"}
    end
  end

  def destroy
    if @category.destroy
    render :json => {status:"Deleted"}
    else
    render :json => {status:"Not Deleted"}
    end
  end
  
  def show
    render :json => @category
  end
 
  def index
    @categories=Category.all
    render :json => @categories
  end

  private

  def set_category
    @category=Category.find_by(id: params[:id])
    if @category.present?
 
    else
      render :json => {status:"No category found against this id"}
    end
  end

  def category_params
    params.permit(:name)
  end

 def require_admin
  if !(logged_in? && current_user.admin?)
    flash[:alert]="Only admins can perform that action"
    redirect_to categories_path
  end
 end

end