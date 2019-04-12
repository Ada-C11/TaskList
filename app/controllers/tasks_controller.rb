class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
    end
  end

  def new
    @task = Task.new
  end

  def create
    task_to_create = Task.new(task_params)

    if task_to_create.save
      redirect_to task_path(task_to_create.id)
    else
      render :new
    end
  end

  def edit
    task_id = params[:id].to_i
    @task_to_edit = Task.find_by(id: task_id)

    if @task_to_edit.nil?
      redirect_to tasks_path
    end
  end

  def update
    task_to_update = Task.find_by(id: params[:id])

    if task_to_update.nil?
      redirect_to tasks_path
    else
      task_to_update.update(task_params)

      redirect_to task_path(task_to_update.id)
    end
  end

  def toggle
    # task_id = params[:id].to_i
    # task_to_toggle = Task.find_by(id: params[:id])

    # if task_to_toggle.nil?
    #   redirect_to tasks_path
    # else
    #   task_to_toggle.toggle(:completed).save
    # end

  end

  def destroy
    task_to_destroy = Task.find_by(id: params[:id])

    if task_to_destroy.nil?
      head :not_found
    else
      task_to_destroy.destroy
      redirect_to tasks_path
    end
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed)
  end
end
