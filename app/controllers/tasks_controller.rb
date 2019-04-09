
TASKS = [
  "wash the dishes", "mow the lawn", "clean the car",
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end

  def show
    task_id = params[:id].to_i
    @task = TASKS[task_id]
  end
end
