# frozen_string_literal: true

def random_time
  Time.at(rand * Time.now.to_i)
end

tasks = [
  { title: "Not a real task", description: "", completed_at: random_time },
  { title: "Pretty important task", description: "" },
  { title: "Pet Eugene. Feed Eugene. Give Eugene whatever he wants.", description: "" },
  { title: "Don't forget to", description: "", completed_at: random_time },
  { title: "Feed Igor", description: "", completed_at: random_time },
  { title: "Nap.", description: "" }
]

tasks.each do |task|
  Task.create task
end
