class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def find_task
    task_id = params[:id]
    task = Task.find_by(id: task_id)

    unless task
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to tasks_path
      return
    end
    return task
  end

  def show
    @task = find_task
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    @task.save

    redirect_to task_path(@task)
  end

  def edit
    @task = find_task
  end

  def update
    task = find_task
    return unless task

    task.update(task_params)

    redirect_to task_path(task)
  end

  def destroy
    task = find_task
    return unless task
    task.destroy

    redirect_to tasks_path
  end

  def complete_toggle
    task = find_task
    return unless task

    # true = ummark complete, sets completion date to nil. false = opposite
    if task.completion_date
      task.completion_date = nil
      task.completed = false
    else
      task.completion_date = Time.now
      task.completed = true
    end

    task.save

    redirect_to tasks_path
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description)
  end
end
