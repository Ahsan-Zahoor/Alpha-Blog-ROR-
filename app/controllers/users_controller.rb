class UsersController <ApplicationController
  before_action :set_user,only: [:show,:edit,:update,:destroy]
  # before_action :require_user, only: [:edit,:update]
  # before_action :require_same_user,only: [:edit,:update,:destroy]
  skip_before_action :verify_authenticity_token

  def show
    @articles=@user.articles
    render :json => {:user=> @user,:article=>@articles}
  end

  def index
    @users= User.all
    render :json => @users
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params(params))
    if @user.save
      session[:user_id]=@user.id
      render :json => @user
      flash[:notice]="Welcome to the Alpha Blog ,#{@user.username}, you have signed up!"
      # redirect_to articles_path
    else
      # render 'new'
      render :json => {status:"error"}
    end
  end

  def destroy
    if @user.destroy
    # session[:user_id] = nil if @user==current_user
    render :json => {status:"Deleted"}
    flash[:notice] = "Account and all associated articles successfully deleted"

    # redirect_to articles_path
    else
    render :json => {status:"Not Deleted"}
    end
  end

  def edit
    render :json => @user
  end

  def update
    # byebug
    if @user.update(user_params(params))
      render :json => @user
      flash[:notice]="Your account information was successfully updated"
      # redirect_to @user
    else
      # render 'edit'
      render :json => {status:"false"}
    end
  end


  private

  def user_params(params)
    params.permit(:username, :email, :password)
  end

  def set_user
    @user=User.find_by(id: params[:id])
    if @user.present?
      # render :json => {status:"User deleted"}
    else
      render :json => {status:"User dont found having this id"}
    end
  end
  
  def require_same_user
    if current_user!=@user && !current_user.admin?
      flash[:alert]="You can only edit or delete your own account"
      # redirect_to @user
      render :json => {status: "not the admin/current user"}
    end
  end

end