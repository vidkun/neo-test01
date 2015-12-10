# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

people = { "George": "Washington", "Thomas": "Jefferson", "Benjamin": "Franklin", "Susie": "Que", "James": "Madison" }

people.each do |k, v|
  Person.create(names: {fullText: "#{k} #{v}", parts: [{value: "#{k}", type: "Given"}, {value: "#{v}", type: "Surname"}]})
end

