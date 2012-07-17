require 'spec_helper'

describe "urls/new" do
  before(:each) do
    assign(:url, stub_model(Url,
      :url => "MyString",
      :rank => 1
    ).as_new_record)
  end

  it "renders new url form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => urls_path, :method => "post" do
      assert_select "input#url_url", :name => "url[url]"
      assert_select "input#url_rank", :name => "url[rank]"
    end
  end
end
