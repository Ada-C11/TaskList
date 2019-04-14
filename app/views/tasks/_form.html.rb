

<%= form_with model: @task do |f| %>

<%= f.label :name, "Task: "%>
<%= f.text_field(:name) %>

<%= f.label :description, "Description of task: "%>
<%= f.text_area(:description) %>

<%= f.label :priority_level, "Priority Level: "%>
<%= f.text_field(:priority_level) %>

<%= f.submit "Submit"%>
<% end %>