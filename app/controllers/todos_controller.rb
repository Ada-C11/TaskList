# frozen_string_literal: true

class TodosController < ApplicationController
  # Todos = ["take a shower", "drink coffee"]
  def index
    @todos = Todo.all
  end

  def show
    todo_id = params[:id].to_i
    @todos = Todo.find_by(id: todo_id)
    # puts '@tasssssk', @todo
  end

  def new
    @todos = Todo.new
  end
end
