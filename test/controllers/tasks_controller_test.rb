require "test_helper"

describe TasksController do
  describe "index" do
    it "renders without crashing" do
      # Arrange

      # Act
      get "/tasks"

      # Assert
      must_respond_with :ok
    end

    it "renders even when there is zero task" do
      TasksController::TASKS.clear

      get "/tasks"

      must_respond_with :ok
    end
  end

  describe "show" do
    it "returns a 404 status code if the task doesn't exist" do
      # Fail case
      task_id = 12345

      get "/tasks/#{task_id}"

      must_respond_with :not_found
    end

    it "works for a task that exists" do

    end
  end
end
