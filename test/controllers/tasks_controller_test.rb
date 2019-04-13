# frozen_string_literal: true

require 'test_helper'
require 'pry'
describe TasksController do
  let (:task) do
    Task.create name: 'sample task', description: 'this is an example for a test',
                completion_date: Time.now + 5.days
  end

  # Tests for Wave 1
  describe 'index' do
    it 'can get the index path' do
      # Act
      get tasks_path

      # Assert
      must_respond_with :success
    end

    it 'can get the root path' do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end

    it 'renders without crashing' do
      # Arrange
      Task.create!(name: 'test task')

      # Act
      get tasks_path

      # Assert
      must_respond_with :ok
    end

    it 'renders even when there is zero task' do
      Task.destroy_all

      get tasks_path

      must_respond_with :ok
    end
  end

  # Unskip these tests for Wave 2
  describe 'show' do
    it 'can get a valid task' do
      # Act
      get task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it 'will redirect for an invalid task' do
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe 'new' do
    it 'can get the new task page' do
      # Act
      get new_task_path

      # Assert
      must_respond_with :success
    end
  end

  describe 'create' do
    it 'can create a new task' do
      # Arrange
      # Note to students:  Your Task model **may** be different and
      #   you may need to modify this.
      task_hash = {
        task: {
          name: 'new task',
          description: 'new task description',
          completion_date: nil
        }
      }

      # Act-Assert
      expect do
        post tasks_path, params: task_hash
      end.must_change 'Task.count', 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Unskip and complete these tests for Wave 3
  describe 'edit' do
    it 'can get the edit page for an existing task' do
      test_task = task

      get edit_task_path(task.id)

      must_respond_with :ok
    end

    it 'will respond with redirect when attempting to edit a nonexistant task' do
      get edit_task_path(-1)

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe 'update' do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it 'can update an existing task' do
      test_task = task
      task_hash = {
        task: {
          name: 'new task',
          description: 'new task description',
          completion_date: nil
        }
      }

      # Act-Assert
      expect {
        patch task_path(test_task), params: task_hash
      }.wont_change 'Task.count'

      # task.update(
      #   name: "updated name",
      #   description: "updated description",
      #   completion_date: nil
      # )

      # expect(task.name).wont_equal before_name
      # expect(task.description).wont_equal before_description

      must_respond_with :redirect
      must_redirect_to task_path
    end

    it 'will redirect to the root page if given an invalid id' do
      # Act
      patch task_path(-1)

      # Assert
      must_respond_with :redirect
      must_redirect_to root_path
      
    end
  end

  # Complete these tests for Wave 4
  describe 'destroy' do
    it 'removes the task from the database' do
      # Arrange
      test_task = task

      # Act
      expect do
        delete task_path(test_task)
      end.must_change 'Task.count', -1

      # Assert
      must_respond_with :redirect
      must_redirect_to tasks_path

      after_task = Task.find_by(id: task.id)
      expect(after_task).must_be_nil
    end

    it 'returns 404 for a task that does not exist' do
      # Arrange
      task_id = 123_456

      # Assumptions
      expect(Task.find_by(id: task_id)).must_be_nil

      # Act
      expect do
        delete task_path(task_id)
      end.wont_change 'Task.count'

      # Assert
      must_respond_with :not_found
    end
  end

  # Complete for Wave 4
  describe 'toggle_complete' do
    # Your tests go here
  end
end
