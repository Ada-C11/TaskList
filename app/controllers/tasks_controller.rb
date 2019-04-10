class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    unless @task
      head :not_found
    end

    def new
      @task = Task.new
      @task.name = "New Task"
      @task.save
    end

    def create
      puts "New task created!"

      task = Task.new(
        name: params["name"],
        description: params["description"],
        completion_date: params["completion date"],
      )

      task.save

      redirect_to tasks_path
    end
  end
end
