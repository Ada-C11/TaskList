TASKS = [
  { Task1: "Make Breakfast", Description: "This is how I make breakfast", Completion_date: "july 12 2019"},
  { Task2: "Go grocery shopping", Description: "This is how I grocery shop", Completion_date: "May 6 2019"},
  { Task3: "Walk the dog", Description: "This is how I walk the dog", Completion_date: "May 7 2019"},
  { Task4: "Finish website", Description: "This is how I finish my website", Completion_date: "June 10 2019"},
  { Task5: "Visit my brother", Description: "This is how I visit my brother", Completion_date: "April 19 2019"},
  { Task6: "Make birthday cards", Description: "This is how I make birthday cards", Completion_date: "May 1 2019"},
  { Task7: "Go to the gym", Description: "This is how I go to the gym", Completion_date: "June 17 2019"},
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
    
  end
end
