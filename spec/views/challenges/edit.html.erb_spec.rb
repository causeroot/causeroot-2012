require 'spec_helper'

describe "challenges/edit" do
  before(:each) do
    @challenge = assign(:challenge, stub_model(Challenge,
      :title => "MyString",
      :url_id => 1,
      :description => "MyText",
      :award => "MyString",
      :image_url_id => "MyString",
      :rules => "MyText"
    ))
  end

  it "renders the edit challenge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => challenges_path(@challenge), :method => "post" do
      assert_select "input#challenge_title", :name => "challenge[title]"
      assert_select "input#challenge_url_id", :name => "challenge[url_id]"
      assert_select "textarea#challenge_description", :name => "challenge[description]"
      assert_select "input#challenge_award", :name => "challenge[award]"
      assert_select "input#challenge_image_url_id", :name => "challenge[image_url_id]"
      assert_select "textarea#challenge_rules", :name => "challenge[rules]"
    end
  end
end
