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
      due_date: params[:task][:due_date],
      completed_date: params[:task][:completed_date],
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

    if !task.nil?
      task.update(
        name: params[:task][:name],
        description: params[:task][:description],
        due_date: params[:task][:due_date],
      )
      redirect_to task_path(task.id)
    else
      redirect_to root_path
    end
  end

  def mark_complete
    task = Task.find_by(id: params[:id])
    if !task.completed
      task.update(
        completed_date: DateTime.now.in_time_zone("Central Time (US & Canada)"),
        completed: true,
      )
    else
      task.update(
        completed_date: nil,
        completed: false,
      )
    end
    redirect_to root_path
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
