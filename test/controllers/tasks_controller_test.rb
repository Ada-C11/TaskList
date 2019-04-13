require "test_helper"

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completion_date: 2010 - 03 - 02
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
          completed: false,
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      task = Task.create!(name: "read", description: "read somethong")
      task_id = task.id
      get edit_task_path(task_id)

      # Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      #Arrange
      task_id = 300
      #Act
      get edit_task_path(task_id)
      #Assert
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do

      # Your code here
      task = Task.create!(name: "new task", description: "making a new one")
      task_data = {
        task: {
          name: "not new",
        },
      }
      #Act
      patch task_path(task), params: task_data
      #Assert
      must_respond_with :redirect
      must_redirect_to task_path(task)

      task.reload
      expect(task.name).must_equal(task_data[:task][:name])
    end

    it "will redirect to the root page if given an invalid id" do

      # Your code here
      #Arrange
      task_id = 55
      #Act
      patch task_path(task_id)
      #Assert
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
    it "will not update if the params are invelid" do
      id = Task.first.id
      original_task = Task.find_by(id: id)

      expect {
        patch task_path(id), params: {}
      }.wont_change "Task.count"

      must_respond_with :error

      task = Task.find_by(id: id)
      expect(task.name).must_equal original_task.name
      expect(task.description).must_equal original_task.description
      expect(task.completion_date).must_equal original_task.completion_date
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here
    it "can destroy a model" do
      #Arrange
      task = Task.create!(name: "read", description: "Read one book per week")
      expect {
        delete task_path(task.id)
      }.must_change "Task.count", -1
      read = Task.find_by(description: "Read one book per week")
      expect(read).must_be_nil
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Complete for Wave 4
  describe "complete" do
    it "will redirect to the main page" do
      post complete_task_path(id: task.id)

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
    it "can mark a task, Mark complete or unmark complete" do
      post complete_task_path(id: task.id)
      completed_task = Task.find_by(completed: true)
      expect(completed_task.completed).must_equal true

    end

    # Your tests go here
  end
end
