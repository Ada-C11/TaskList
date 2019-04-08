TASKS = [
  { task: "Set alarm" },
  { task: "Make Breakfast" },
  { task: "Make Lunch" },
  { task: "Make Dinner" },
  { task: "Exercise" },
  { task: "Do Homework" },
]

class TasksController < ApplicationController
  def index
    # add an instance variable here
    @tasks = TASKS
  end

  def featured_task
    @featured = @tasks.sample
  end

  def show
    task_id = params[:id]
    puts "Task Id is #{task_id}"

    @task = TASKS[task_id.to_i]
    # @task = Task.find(task_id) -- when we learn about Models

    unless @task
      head :not_found # barely step above raising an exception. 
    end
  end
end
