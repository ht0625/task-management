class Admin::UsersController < ApplicationController
  before_action :set_id, only: [:show,:edit, :update, :destroy]
  before_action :admin_user?
  def index
    @users = User.select(:id, :name, :email,:admin, :created_at).includes(:tasks).order("created_at ASC")
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end
  def show
    @tasks = @user.tasks.order(created_at: :desc)
  end
  def edit
  end
  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "編集しました。"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "削除しました。"
  end
  private

  def set_id
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email,:admin, :password, :password_confirmation)
  end

  def admin_user?
    if current_user[:admin] != true
      redirect_to tasks_path, notice: '管理者以外はアクセスできません'
    end
  end
end
