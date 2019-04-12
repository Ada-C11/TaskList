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
    @task = Task.new(name: "Task")
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

  def edit
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
    end
  end

  def update
    task_id = params[:id].to_i
    task = Task.find_by(id: task_id)

    # save??

    if task.nil?
      redirect_to task_path(@task.id)
    else
      task.update
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])

    if task.nil?
      head :not_found
    else
      task.destroy
      redirect_to tasks_path
    end
  end
end
