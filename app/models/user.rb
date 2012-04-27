class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :encryptable, :confirmable, :timeoutable,
         :omniauthable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = self.find_by_email(data.email)
      user
    else # Create a user with a stub password. 
      self.new(:email => data.email, :first_name => data.first_name, :last_name => data.last_name)
   end
  end

  def self.find_for_open_id(access_token, signed_in_resource=nil)
    data = access_token.info
    if user = User.where(:email => data["email"]).first
      user
    else
      User.create!(:email => data["email"], :password => Devise.friendly_token[0,20])
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end
end
