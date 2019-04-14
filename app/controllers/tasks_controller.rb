# frozen_string_literal: true

TASK_LIST = [
  { id: 1, name: 'Wake up', description: 'only one alarm' },
  { id: 2, name: 'Take a shower', description: 'limit to 15 min' }
].freeze

class TasksController < ApplicationController
  def index
  @tasks = TASK_LIST
  end
end
