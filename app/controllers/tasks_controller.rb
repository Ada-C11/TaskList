TASKS = ["Feed the bird", "Give the guinea pig hay", "Eat breakfast", "Get the kids to do chores"]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end

  def show
    task_id = params[:id]
    @task = TASKS[task_id.to_i]
  end
end
