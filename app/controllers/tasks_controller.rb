class TasksController < ApplicationController
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
    task = Task.new(task_params)
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
    edit_task_id = params[:id].to_i
    edited_task = Task.find_by(id: edit_task_id)

    if edited_task != nil
      edited_task.update(task_params)
      redirect_to root_path
    else
      redirect_to root_path
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

  def toggle
    @complete_task = Task.find_by(id: params[:id])
    # is_complete = complete_task.update(status )
    if @complete_task.update(:status => false)
      redirect_to tasks_path
    else
      @complete_task.update(:status => true)
      redirect_to tasks_path
    end
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completion_date, :status => false)
  end
end
