require 'spec_helper'

#  attr_accessible :award, :deadline, :description, :image_url, :post_date, :rules, :title, :url

describe Challenge do
	it "should require a name" do
		Challenge.new(:name => "").should_not be_valid
	end
	it "should require a description" do
		Challenge.new(:description => "").should_not be_valid
	end
	it "should have valid factory" do
		challenge = FactoryGirl.create(:challenge)
		challenge.should be_valid
	end
end
