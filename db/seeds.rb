# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

questions = YAML::load_file('db/questions.yml')
questions.each {|key, value| Question.create(value) }

["Proliferation of Genetically Modified Food",
  "The magnitude of US debt",
  "The War on Drugs",
  "Drinking and Driving",
  "The lack of moral conviction in American Society",
  "The Middle Eastern Conflict",
  "The increase of Greenhouse gases",
  "Proliferation of Nuclear Weapons"].each do |prob| 

        i = FactoryGirl.create(:issue)
        i.problem = prob
        i.causes << FactoryGirl.create(:cause)
        i.effects << FactoryGirl.create(:effect)
        i.save
end

game_result = YAML::load_file('db/game_result.yml')
game_result.each {|key, value| GameResult.create(value) }