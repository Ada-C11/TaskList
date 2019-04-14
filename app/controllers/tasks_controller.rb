class TasksController < ApplicationController
  def index
    @tasks = Task.where(complete: !true)
    @completed_tasks = Task.where(complete: true)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new
    unless params["task"]
      render :new, status: :bad_request
      return
    end

    @task.name = params[:task][:name]
    @task.description = params[:task][:description]
    if params[:task][:date]
      @task.date = Date.parse(params[:task][:date])
    end
    @task.complete = false

    @task.save

    redirect_to task_path(@task.id)
  end

  def show
    task_id = params[:id]

    @task = Task.find_by(id: task_id)
    unless @task
      redirect_to tasks_path
      return
    end

    head :not_found unless @task
  end

  def edit
    @task = Task.find_by(id: params[:id])
    unless @task
      redirect_to tasks_path
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])

    unless @task
      redirect_to tasks_path
      return
    end

    @task.name = params[:task][:name]
    @task.description = params[:task][:description]
    if params[:task][:date]
      @task.date = Date.parse(params[:task][:date])
    end

    @task.save
    redirect_to task_path(@task)
  end

  def destroy
    task_id = params[:id]

    task = Task.find_by(id: task_id)

    unless task
      head :not_found
      return
    end

    task.destroy

    redirect_to tasks_path
  end

  def toggle_complete
    task_id = params[:id]
    task = Task.find_by(id: task_id)

    unless task
      head :not_found
      return
    end

    task.complete == true ? task.complete = false : task.complete = true
    task.save

    redirect_to tasks_path
  end
end
