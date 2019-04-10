# frozen_string_literal: true

class TodosController < ApplicationController
  # Todos = ["take a shower", "drink coffee"]
  def index
    @todos = Todo.all
  end

  def show
    task_id = params[:id].to_i
    @task = Todo.find_by(id: task_id)
    puts '@taksssss', @task.description
  end
end
