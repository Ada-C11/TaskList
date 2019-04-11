class TasksController < ApplicationController
  TASKS = [
    {todo: "Task List Project", when: "today"},
    {todo: "Groceries", when: "Friday"},
  ]

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      head :temporary_redirect
    end
  end

  def new
    @task = Task.new(name: "Default")
  end

  def create
    task = Task.new(
      name: params["task"]["name"],
      description: params["task"]["description"],
      completion_date: params["task"]["completion_date"],
    )

    if task.name == "" || task.description == "" || task.completion_date == ""
      task.save = false
    end

    is_successful = task.save

    if is_successful
      redirect_to task_path(task.id)
    else
      head :temporary_redirect
    end
  end
end
