class TasksController < ApplicationController
  TASKS = [ "Task One", "Task Two", "Task Three", "Task Four"
  ]
  
  def index
    @tasks = TASKS
  end

  def show
    task_id = params[:id]

    puts "Task ID was #{task_id}"

    @task = TASKS[task_id.to_i]

    unless @task
      head :not_found
    end
  end
end
