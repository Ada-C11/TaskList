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
end
