class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if !@task
      redirect_to tasks_path, flash: { error: "Could not find task with id: #{task_id}" }
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      name: params["task"]["name"],
      description: params["task"]["description"],
    )

    task.save

    redirect_to tasks_path, flash: { alert: "Task added successfully" }
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if !@task
      redirect_to tasks_path, flash: { alert: "No such task" }
    end
  end

  def update
    task = Task.find_by(id: params[:id])

    if task
      task.update(name: params["task"]["name"], description: params["task"]["description"], completion_date: params["task"]["completion_date"], completed: params["task"]["completed"])

      redirect_to task_path(params[:id])
    else
      redirect_to tasks_path, flash: { alert: "No such task" }
    end
  end

  def destroy
    task_id = params[:id]
    task = Task.find_by(id: task_id)

    if task
      task.destroy
      redirect_to tasks_path, flash: { alert: "Task successfully deleted" }
    else
      redirect_to tasks_path, flash: { alert: "No such task" }
    end
  end

  def complete
    task_id = params[:id]
    task = Task.find_by(id: task_id)

    if task
      if task.completed == false
        task.update(completed: true)
        redirect_to tasks_path
      else
        task.update(completed: false)
        redirect_to tasks_path
      end
    else
      redirect_to tasks_path, flash: { alert: "No such task" }
    end
  end
end
