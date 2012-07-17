require 'spec_helper'

describe "challenges/show" do
  before(:each) do
    @challenge = assign(:challenge, stub_model(Challenge,
      :title => "Title",
      :url_id => 1,
      :description => "MyText",
      :award => "Award",
      :image_url_id => "Image Url",
      :rules => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/1/)
    rendered.should match(/MyText/)
    rendered.should match(/Award/)
    rendered.should match(/Image Url/)
    rendered.should match(/MyText/)
  end
end
