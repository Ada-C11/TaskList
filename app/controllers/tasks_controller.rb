class TasksController < ApplicationController
  # TASKS = [
  #   { name: "plant flowers", description: "use seeds for sunflowers and other hardy flowers, plant and water in the open plot", deadline: 20190423, date_completed: 20190410, priority_level: "low" },
  #   { name: "finish rails project", description: "instructions for this super fun project found on github", deadline: 20190415, date_completed: 20190415, priority_level: "high" },
  #   { name: "file taxes", description: "adulting, ask your mother-in-law if you need help", deadline: 20190415, date_completed: 20190413, priority_level: "high" },
  #   { name: "do physical therapy", description: "take care of damaged spine and joints and manage pain", deadline: 20190411, date_completed: 20190412, priority_level: "medium" },
  #   { name: "call mama", description: "think of something safe to talk about", deadline: 20190414, date_completed: 20190413, priority_level: "medium" },
  # ]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    puts "You are so busy and important! Task added."

    @task = Task.new

    unless params["task"]
      render :new, status: :bad_request
      return
    end

    @task.name = params["task"]["name"]
    @task.description = params["task"]["description"]
    @task.deadline = params["task"]["deadline"]
    @task.date_completed = params["task"]["date_completed"]
    @task.priority_level = params["task"]["priority_level"]

    # binding.pry

    @task.save

    redirect_to task_path(@task.id)
  end

  def show
    task_id = params[:id]
    puts "Task ID was #{task_id}"
    puts "Result of .to_i: #{task_id.to_i}"
    # binding.pry

    @task = Task.find_by(id: task_id)

    # binding.pry

    unless @task
      redirect_to tasks_path, flash: { error: "Could not find task with id #{task_id}." }
    end
  end
end
