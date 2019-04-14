class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create

    task = Task.new( 
      name: params["task"]["name"], 
      description: params["task"]["description"],
      completion_date: params["task"]["completion_date"],
      completed: false
      )

    task.save
    redirect_to tasks_path

  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id:task_id)

    unless @task
        redirect_to tasks_path
    end
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id:task_id)
    unless @task
      redirect_to tasks_path
    end
  end

  def update
    task_id = params[:id]
    @task = Task.find_by(id:task_id)
    if @task == nil
      redirect_to tasks_path
    else
      @task.update(name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date])
      redirect_to task_path(@task)
    end

  end

  def complete
    task_id = params[:id]
  
    @task = Task.find_by(id:task_id)
    if @task == nil
      redirect_to tasks_path
    elsif @task.completed == false
      @task.update(completion_date: Time.now.to_s, completed: true)
      redirect_to tasks_path
    else
      @task.update(completion_date: "not completed", completed: false)
      redirect_to tasks_path
    end
  end

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
  
    if @task
      @task.destroy
      redirect_to tasks_path
    else
      render :notfound, status: :not_found
    end
  end

end