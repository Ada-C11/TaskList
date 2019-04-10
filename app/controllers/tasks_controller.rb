class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]

    @task = Task.find_by(id: task_id)

    unless @task
      redirect_to tasks_path, :flash => {:error => "Could not find task with id: #{task_id}"}
    end
  end

  def new
    @task = Task.new
  end
end
