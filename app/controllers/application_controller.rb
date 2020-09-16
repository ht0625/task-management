class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  # def ensure_correct_user
  #   if current_user.id !=  @user.user_id
  #     redirect_to tasks_path,notice: 'アクセスできません'
  #   end
  # end
end
