# frozen_string_literal: true

# require "test_helper"

# describe TasksController do
#   describe "show" do
#     it "should be able to show a valid task" do
#       task = Task.create(title: "test task")

#       get task_path(task.id)
#       must_respond_with :success
#     end
# 

require 'test_helper'

describe TasksController do
  let (:task) do
    Task.create title: 'sample task', description: 'this is an example for a test',
                completed_at: nil
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
  end
  # Unskip these tests for Wave 2
  describe 'show' do
    before do
      Task.create title: "This is a test", description: "Only a test"
    end
    it 'can get a valid task' do
      # Act
      get task_path(Task.first.id)
      # Assert
      must_respond_with :success
    end
    it 'will redirect for an invalid task' do
      # Act
      get task_path(-1)
      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal 'Could not find task with id: -1'
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
      task_hash = {
        task: {
          name: 'new task',
          description: 'new task description',
          completed_at: nil
        }
      }
      # Act-Assert
      expect do
        post tasks_path, params: task_hash
        # Assert - Creates a task
      end.must_change 'Task.count', 1

      # Assert - the new task has the right data
      new_task = Task.find_by(title: task_hash[:task][:title])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completed).must_equal false

      # Assert - It should redirect you someplace
      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Unskip and complete these tests for Wave 3
  describe 'edit' do
    it 'can get the edit page for an existing task' do
      skip
      # Your code here
    end
    it 'will respond with redirect when attempting to edit a nonexistant task' do
      skip
      # Your code here
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe 'update' do
    before do
      Task.create title: "This is a test", description: "Only a test"
    end
    it 'can update an existing task' do
      # Arrange
      test_id = Task.last.id
      task_hash = {
        task: {
          title: 'updated task title',
          description: 'updated description'
        }
      }

      expect do
        patch task_path(test_id), params: task_hash
      end.wont_change 'Task.count'

      updated_task = Task.find_by(title: task_hash[:task][:title])

      expect(updated_task.description).must_equal task_hash[:task][:description]

      must_respond_with :redirect
      must_redirect_to task_path(test_id)
    end

    it 'will redirect to the root page if given an invalid id' do
      # Act      test_id = Task.last.id
      task_hash = {
        task: {
          title: 'updated task title',
          description: 'updated description'
        }
      }
      patch task_path(-1), params: task_hash

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal 'Could not find task with id: -1'

      must_redirect_to tasks_path
    end
  end

  # Complete these tests for Wave 4
  describe 'destroy' do
    before do
      Task.create title: "This is a test", description: "Only a test"
    end

    it 'removes the test from the database' do
      # Arrange
      test_id = Task.last.id

      # Act
      expect do
        delete task_path(test_id)
      end.must_change 'Task.count', -1

      # Assert
      expect(Task.find_by(id: test_id)).must_equal nil

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it 'redirects to root if the task does not exist' do
      # Arrange
      test_id = -1

      # Act

      delete task_path(test_id)

      # Assert
      must_respond_with :not_found
    end
  end

  # Complete for Wave 4
  describe 'complete' do
    before do
      Task.create title: "This is a test", description: "Only a test"
    end

    it 'can mark an incomplete task complete without changing anything else' do
      # Arrange
      test_task = Task.last
      initial_attributes = test_task.attributes.clone

      # Act-Assert
      expect do
        patch complete_task_path(test_task.id)
      end.wont_change 'Task.count'

      test_task.reload
    # Completion date should change, but nothing else should.
      expect(test_task.title).must_equal initial_attributes['title']
      expect(test_task.description).must_equal initial_attributes['description']
      expect(test_task.completed?).must_equal true;
      # expect(test_task.completed_at).must_equal task_hash[:task][:completed_at]
      must_respond_with :redirect
      must_redirect_to root_path
    end

    it 'will redirect to the root page if given an invalid id' do
      # Act
      patch task_path(-1)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal 'Could not find task with id: -1'

      must_redirect_to tasks_path
    end
  end
end
