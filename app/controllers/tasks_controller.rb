class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    head :not_found if @task.nil?
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description],
    )

    if task.save
      redirect_to task_path(task.id)
    else
      head :bad_request
    end
  end
end
