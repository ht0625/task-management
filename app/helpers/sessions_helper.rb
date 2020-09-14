module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def logged_in?
    current_user.present?
  end
  def authenticate_user
    if current_user == nil
      redirect_to new_session_path, notice: 'ログインが必要です'
    end
  end
  def judge_new_action
    if logged_in?
      redirect_to user_path(@current_user.id), notice: 'ログイン中はアクセスできません'
    end  
  end
end
