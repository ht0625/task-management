class Admin::UsersController < ApplicationController
  def index
    @users = User.all.order("created_at ASC")
  end
end
