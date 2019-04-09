class TasksController < ApplicationController
  # TASKS = [
  #   { task: "PR for CS Fun" },
  #   { task: "TaskList project" },
  # ]

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      head :not_found
    end
  end
end
