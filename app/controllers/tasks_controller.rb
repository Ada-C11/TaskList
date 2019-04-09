class TasksController < ApplicationController
  TASKS = [
    { one: "create a route to view the task index page" },
    { two: "create a controller action for the task index page which contains an array of hard-coded tasks"},
    { three: "create an ERB view to display the tasks from the controller action"}
  ]
  
  def index
    @tasks = TASKS
  end

  def show
    task_id = params[:id]

    @task = TASKS[task_id.to_i] #remove this later
    #@book = Book.find(book_id)

    unless @task
      head :not_found #head is short for http headers
    end
  end
end
