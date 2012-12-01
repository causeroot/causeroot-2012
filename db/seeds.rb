# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

questions = YAML::load_file('db/questions.yml')
questions.each {|key, value| Question.create(value) }

issues = YAML::load_file('db/issues.yml')
issues.each {|key, value| Issue.create(value) }
