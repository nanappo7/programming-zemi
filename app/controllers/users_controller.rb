class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)   # 実装は終わっていないことに注意!
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
	
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

  


  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
