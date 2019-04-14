class TasksController < ApplicationController
  # TASKS = [
  #   { name: "Go to the store", day_due: "Monday" },
  #   { name: "File taxes", day_due: "Wednesday" },
  #   { name: "Buy cat food and litter", day_due: "Friday" },
  #   { name: "Buy ferry ticket to Victoria", day_due: "Saturday" },
  # ]

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to action: "index", status: 302
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date])
    if @task.save
      redirect_to root_path
    else
      render :new
    end
  end
end
