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
      task = Task.create!(name: "original test task")
      task_data = {
        task: {
          name: "updated test task",
        },
      }

      # Act
      patch task_path(task), params: task_data

      # Assert
      must_respond_with :redirect
      must_redirect_to task_path(task)

      task.reload
      expect(task.name).must_equal(task_data[:task][:name])
    end

    it "will redirect to the root page if given an invalid id" do
      # Act
      get task_path(id: -1)

      # Assert
      must_redirect_to tasks_path
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "removes the book from the database" do
      # Arrange
      task = Task.create!(name: "DESTROY_task")

      # Act
      expect {
        delete task_path(task)
      }.must_change "Task.count", -1

      # Assert
      must_respond_with :redirect
      must_redirect_to tasks_path

      after_task = Task.find_by(id: task.id)
      expect(after_task).must_be_nil
    end
  end

  # Complete for Wave 4
  describe "mark complete" do
    it "updates the database" do
      task = Task.create!(name: "test_for_complete")

      # Act
      patch complete_path(task.id)

      # Assert
      after_task = Task.find_by(id: task.id)
      expect(after_task.completed_at).wont_be_nil
      expect(after_task.completed_at).must_be_kind_of Time
    end
  end
end
