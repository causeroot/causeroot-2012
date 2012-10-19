class Subscription < ActiveRecord::Base
  attr_accessible :email
  validates :email, :presence => true # optionally validate format of email
end
