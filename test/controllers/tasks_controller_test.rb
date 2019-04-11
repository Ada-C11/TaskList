# frozen_string_literal: true

require "test_helper"

describe TasksController do
  describe "show" do
    it "should be able to show a valid task" do
      task = Task.create(title: "test task")

      get task_path(task.id)
      must_respond_with :success
    end

    it "renders 404 not found for an invalid task" do
      task_id = Task.last.id + 1

      get edit_task_path(task_id)

      must_respond_with :not_found
    end
  end
end
