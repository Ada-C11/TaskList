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
end
