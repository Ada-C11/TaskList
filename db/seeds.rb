# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
tasks = Task.create([
                      { title: "Fake Task", description: "Don't work too hard on this. It's not a real task." },

                      { title: "Another Fake Task", description: "Get help. Fake tasks are really hard." },

                      { title: "Very Fake Task", description: "Remember to use soap." }
                    ])
