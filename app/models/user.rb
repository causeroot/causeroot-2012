class User < ActiveRecord::Base
	authenticates_with_sorcery!
	
  attr_accessible :username, :email, :password, :password_confirmation
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email  
  validates_length_of :password, :minimum => 8, :message => "password must be at least 8 characters long", :if => :password
end
