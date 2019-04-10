class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  # def show
  #   task_id = params[:id]

  #   @task = Task.find(task_id)
  # end

  def new
    @task = Task.new
  end
end
