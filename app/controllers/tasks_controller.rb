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
    task = Task.new(task_params) #instantiate a new book
    if task.save # save returns true if the database insert succeeds
      redirect_to task_path(task.id)  #why not task_path
      #   redirect_to root_path
      # go to the index so we can see the book in the list
    else # save failed :(
      render :new # show the new book form view again
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
    end
  end

  def update
    task = Task.find_by(id: params[:id])
    if task.nil?
      redirect_to tasks_path
    end
    task.update(task_params)
    redirect_to task_path(task.id)
  end

  def delete
    edit
  end

  def destroy
    task = Task.find_by(id: params[:id])
    task.destroy
    redirect_to tasks_path
  end

  def toggle_completion
    task = Task.find_by(id: params[:id])
    task.toggle(:completion).save
    redirect_to tasks_path
  end

  private

  def task_params
    return params.require(:task).permit(:title, :description, :completion)
    #should replace title: params[:task][:title], description: params[:task][:description], completion: params[:task][:completion]
  end
end
