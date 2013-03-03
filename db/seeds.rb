##    CauseRoot Foundation, hereby disclaims all copyright interest in the program 

##    This file is part of CauseRoot.

##    CauseRoot is free software: you can redistribute it and/or modify
##    it under the terms of the GNU General Public License as published by
##    the Free Software Foundation, either version 3 of the License, or
##    (at your option) any later version.

##    Foobar is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##    GNU General Public License for more details.

##    You should have received a copy of the GNU General Public License
##    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.


# no funny business. one issue per line. this script is idempotent.
# anything in issues.txt will be added to the database. 

require 'securerandom'

issues_filename = File.expand_path(File.dirname(__FILE__)) + '/issues.txt'

if ! User.exists?(:username => "causeroot")
  puts "Adding causeroot user."
  user_one = User.new;
  user_one.username = 'causeroot'
  user_one.email = 'info@causeroot.org'
  user_one.password = SecureRandom.urlsafe_base64(20)
  user_one.save!
else
  puts "User causeroot already exists. Skipping."
end


File.open(issues_filename).each do |prob|
  if ! Issue.exists?(:problem => prob)
    puts "Adding issue: #{prob}"
    i = Issue.new
    i.user = user_one
    i.problem = prob
    i.save!
  else
    puts "Issue already exists. Skipping."
  end
end

questions = YAML::load_file('db/questions.yml')
questions.each {|key, value| Question.create(value) unless Question.exists?(:name => value[:name]) }