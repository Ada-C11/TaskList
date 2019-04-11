class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to root_path
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description],
      completed: params[:task][:completed],
    )
    is_sucessful = task.save

    if is_sucessful
      redirect_to task_path(task.id)
    else
      head :not_found
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to root_path
    end
  end

  def update
    task = Task.find_by(id: params[:id])

    if task.nil?
      redirect_to root_path
    else
      task.update(
        name: params[:task][:name],
        description: params[:task][:description],
        completed: params[:task][:completed],
      )
      redirect_to root_path
    end
  end

  def mark_complete
    task = Task.find_by(id: params[:id])

    task.update(
      completed: true,
    )
  end

  def destroy
    task = Task.find_by(id: params[:id])

    if task.nil?
      head :not_found
    else
      task.destroy
      redirect_to root_path
    end
  end
end
