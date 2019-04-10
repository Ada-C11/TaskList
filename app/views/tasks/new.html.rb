<h2> New Task Form </h2>

<%= form_with model: @task, class: 'task-form' do |f| %>
  <p>Please fill out this Task data </p>

  # <div>
  #   <%= f.label :name, "Please enter a task name" %>
  #   <%= f.text_field :name, placeholder: "a task" %>
  # </div>

  <div>
    <%= f.label :description %>
    <%= f.text_field :description, placeholder: "task description" %>
  </div>

  <div>
  <%= f.label :completion_date %>
  <%= f.text_field :completion_date, placeholder: "task completion date" %>
  </div>

  <%= f.submit "Save it!" %>

<% end %>