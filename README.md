Get Ready
======
* Sign up for github: https://github.com/signup/free
* Install git: http://git-scm.com/download
* Install rvm: https://rvm.io//rvm/install/
* Install ruby `rvm install 1.9.3-p194`
* Use ruby 1.9.3: `rvm use 1.9.3-p194 --default`
* Update RubyGems: `gem update --system` 
* Install bundler: `gem install bundler`

Install
======
* Check out the source: `git clone git://github.com/gardner/carrio.git`
* Change into src dir: `cd carrio`
* Install required gems: `bundle install` [read this if you receive errors](http://stackoverflow.com/questions/9345622/error-running-bundle-install-using-ruby-1-9-3 "Troubleshoot")
* If Nokogiri installation fails [please read this page](http://nokogiri.org/tutorials/installing_nokogiri.html) the solution is system dependent. Please be sure to install version 1.5.2
* Configure your database setup: `cp config/database.yml.example config/database.yml`
* Initialize the database: `rake db:create; rake db:migrate`
* Run the app: `rails server`
* Go to http://127.0.0.1:3000
