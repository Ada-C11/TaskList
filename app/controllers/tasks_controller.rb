class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(:id)
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
    task = Task.new(task_params)

    if task.name != ""
      task.save

      redirect_to tasks_path, flash: { alert: "Task added successfully" }
    else
      redirect_to new_task_path
    end
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
      task.update(task_params)

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
      if !task.completed
        task.update(completed: true, completion_date: Date.today)

        redirect_to tasks_path
      else
        task.update(completed: false, completion_date: nil)
        redirect_to tasks_path
      end
    else
      redirect_to tasks_path, flash: { alert: "No such task" }
    end
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completion_date, :completed)
  end
end
