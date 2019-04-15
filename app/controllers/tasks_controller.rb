class TasksController < ApplicationController
  def root
    @message = 'Hello world!'
  end

  def show
    # This is the ruby try-catch.
    # If Task.find throws an exception
    # (e.g., can't find a task with that id)
    # then we can catch the exception and
    # redirect the user to the homepage with a message.
    begin
      @task = Task.find(params['id'])
    rescue
      flash[:error] = "Could not find task with id: #{params['id']}" #not printing??? why!
      redirect_to tasks_path
      return
    end
  end

  def index
    @tasks = Task.all
  end

  def create
    unless params.key?(:task)
      @task = Task.new
    else
      @task = Task.new(
        name: params[:task][:name],
        description: params[:task][:description]
      )
      if @task.save
        new_task = Task.find_by(name: @task.name)
        redirect_to task_path(new_task.id)
      else
        render :new
      end
    end
  end

  def edit
    begin
      @task = Task.find(params['id'])
    rescue
      flash[:error] = "Could not find task with id: #{params['id']}"
      redirect_to tasks_path
      return
    end
  end

  def update
    begin
      @task = Task.find(params[:id])
    rescue
      flash[:error] = "Could not find task with id: #{params['id']}"
      redirect_to tasks_path
      return
    end

    begin
      if params[:task].key?(:completion_date)
        @task.update(
          name: params[:task][:name],
          description: params[:task][:description],
          completion_date: params[:task][:completion_date]
        )
      else
        @task.update(
          name: params[:task][:name],
          description: params[:task][:description]
        )
      end
      redirect_to task_path(params[:id])
    rescue
      render :new
      return
    end
  end

end
