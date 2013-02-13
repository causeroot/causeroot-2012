require 'spec_helper'
#   attr_accessible :username, :email, :password, :password_confirmation

describe Graph do
  it "should generate csv" do
    10.times { FactoryGirl.create(:game_result_with_issues) }
    str = Graph.grabdata
  end
end
