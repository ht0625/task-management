class Admin::UsersController < ApplicationController
  def index
    @users = User.all.order("created_at ASC")
  end
  def new
    @user = User.new
  end
  
end
