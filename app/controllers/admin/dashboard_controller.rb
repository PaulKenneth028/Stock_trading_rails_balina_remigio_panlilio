class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:edit, :update, :show]

  def index
    @users = User.all
  end

  def show
    # The 'show' action is usually used to display details of a single record.
    # You might want to remove @users = User.all from here and use @user instead.
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_dashboard_index_path, notice: 'User created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_dashboard_path, notice: "User successfully updated."
    else
      render :edit
    end
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: 'Access denied.' unless current_user&.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :admin)
  end
end
