require 'spec_helper'

describe "challenges/index" do
  before(:each) do
    assign(:challenges, [
      stub_model(Challenge,
        :title => "Title",
        :url_id => 1,
        :description => "MyText",
        :award => "Award",
        :image_url_id => "Image Url",
        :rules => "MyText"
      ),
      stub_model(Challenge,
        :title => "Title",
        :url_id => 1,
        :description => "MyText",
        :award => "Award",
        :image_url_id => "Image Url",
        :rules => "MyText"
      )
    ])
  end

  it "renders a list of challenges" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Award".to_s, :count => 2
    assert_select "tr>td", :text => "Image Url".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
