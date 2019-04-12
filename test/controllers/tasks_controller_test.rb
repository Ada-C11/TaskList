require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completion_date: Time.now + 5.days
  }

  # Tests for Wave 1
  describe "index" do
    it "can get the index path" do
      # Act
      get tasks_path

      # Assert
      must_respond_with :success
    end

    it "can get the root path" do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end
  end

  # Unskip these tests for Wave 2
  describe "show" do
    it "can get a valid task" do

      # Act
      get task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new task page" do

      # Act
      get new_task_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new task" do

      # Arrange
      # Note to students:  Your Task model **may** be different and
      #   you may need to modify this.
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completion_date: "Mon, 01 Apr 2019",
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completion_date).must_be_kind_of Date

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_task_path(1)

      # Assert
      must_respond_with :found
    end

    it "will respond with redirect when attempting to edit a nonexistent task" do
      get edit_task_path(5555555)

      must_respond_with :redirect
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      patch task_path(1)
      # Your code here
      must_respond_with :success
      must_redirect_to :tasks_path
    end

    it "will redirect to the root page if given an invalid id" do
      skip
      # Your code here
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here

  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end
