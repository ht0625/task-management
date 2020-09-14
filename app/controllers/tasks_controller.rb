class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired] == "true"
      @tasks = current_user.tasks.order(deadline: :desc).page(params[:page]).per(10)
    elsif params[:sort_priority] == "true"
      @tasks = current_user.tasks.order(priority: :desc).page(params[:page]).per(10)
    elsif params[:task].present?
      if params[:task][:name_key].present? && params[:task][:status_key].present?
        @tasks = current_user.tasks.name_search(params[:task][:name_key]).status_search(params[:task][:status_key]).page(params[:page]).per(10)
      elsif params[:task][:name_key].present?
        @tasks = current_user.tasks.name_search(params[:task][:name_key]).page(params[:page]).per(10)
      elsif params[:task][:status_key].present?
        @tasks = current_user.tasks.status_search(params[:task][:status_key]).page(params[:page]).per(10)
      end
    else
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(10)
    end

  end

  def new
    @task = Task.new
  end
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to task_path(@task.id),notice: "登録しました"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集しました。"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "削除しました。"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :content, :deadline, :status, :priority)
  end

end
