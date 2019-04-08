TASKS = [
  {id: 1, task: "Set alarm"}, 
  {id: 2, task: "Make Breakfast"}, 
  {id: 3, task: "Make Lunch"}, 
  {id: 4, task: "Make Dinner"}, 
  {id: 5, task: "Exercise"}, 
  {id: 6, task: "Do Homework"}
]

class TasksController < ApplicationController
  def index
    # add an instance variable here
    @tasks = TASKS
  end

  def show
    task_id = params[:id]

    @task = TASKS[task_id]
   # @task = Task.find(task_id) -- when we learn about Models
  end
end
