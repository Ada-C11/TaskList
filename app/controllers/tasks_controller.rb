# require_relative '../models/task.rb'

# TASKS = [
#   { Task1: "Make Breakfast", description: "This is how I make breakfast", completion_date: "july 12 2019"},
#   { Task2: "Go grocery shopping", description: "This is how I grocery shop", completion_date: "May 6 2019"},
#   { Task3: "Walk the dog", description: "This is how I walk the dog", completion_date: "May 7 2019"},
#   { Task4: "Finish website", description: "This is how I finish my website", completion_date: "June 10 2019"},
#   { Task5: "Visit my brother", description: "This is how I visit my brother", completion_date: "April 19 2019"},
#   { Task6: "Make birthday cards", description: "This is how I make birthday cards", completion_date: "May 1 2019"},
#   { Task7: "Go to the gym", description: "This is how I go to the gym", completion_date: "June 17 2019"},
# ]

class TasksController < ApplicationController

  def index # Loads a list of all the books
    @tasks = Task.all
    return @tasks
  end

end
