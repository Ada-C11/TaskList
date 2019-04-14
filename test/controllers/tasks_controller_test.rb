require "test_helper"

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) {
    Task.create title: "sample task", description: "this is an example for a test",
                completion: false
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
          title: "new task",
          description: "new task description",
          completion: false,
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(title: task_hash[:task][:title])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completion).must_equal task_hash[:task][:completion]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do

      #expect edit task link to redirect to edit page
      get edit_task_path(task.id)

      must_respond_with :success
      # Your code here
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      # Act
      get edit_task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      # Arrange
      # Note to students:  Your Task model **may** be different and
      #   you may need to modify this.
      edit_hash = {
        task: {
          title: "edited task",
        },
      }

      patch task_path(task.id), params: edit_hash
      task.reload

      expect(task.title).must_equal edit_hash[:task][:title]
    end

    it "will redirect to the root page if given an invalid id" do
      edit_hash = {
        task: {
          title: "edited task",
        },
      }

      patch task_path(999), params: edit_hash

      must_respond_with :redirect
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "deletes something" do
      test_task = Task.create(title: "poop", description: "more poop", completion: false)
      # Your tests go here
      expect {
        delete task_path(test_task.id)
      }.must_change "Task.count", -1

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "redirects to task page" do
      test_task = Task.create(title: "poop", description: "more poop", completion: false)
      delete task_path(test_task.id)

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    it "marks as complete" do
      test_task = Task.create(title: "poop", description: "more poop", completion: false)

      get mark_complete_path(test_task.id)
      # patch mark_complete_path(test_task.id)

      expect(test_task.completion).must_equal true
    end

    it "redirects to task page" do
      test_task = Task.create(title: "poop", description: "more poop", completion: false)
      patch mark_complete_path(test_task.id)

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end
end
