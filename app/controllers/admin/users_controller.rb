class Admin::UsersController < ApplicationController
  before_action :set_id, only: [:show,:edit, :update, :destroy]
  def index
    @users = User.select(:id, :name, :email, :created_at).includes(:tasks).order("created_at ASC")
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
