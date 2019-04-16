class TasksController < ApplicationController
  TASKS = [
    {name: "mow", description: "front and back lawn"},
    {name: "dishes", description: "load dishwasher"},
  ]

  def index
    @tasks = TASKS
  end

  def show
    task_id = params[:id].to_i
    @task = TASKS[task_id]
    #if the task is nonexistent, we will give back a 404 status
    if @task.nil?
      head(:not_found) #parentheses not needed for head technically
    end
  end
end
