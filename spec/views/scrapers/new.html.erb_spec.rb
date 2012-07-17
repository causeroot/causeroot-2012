require 'spec_helper'

describe "scrapers/new" do
  before(:each) do
    assign(:scraper, stub_model(Scraper,
      :name => "MyString",
      :url_id => 1,
      :site_id => 1,
      :rule_id => 1
    ).as_new_record)
  end

  it "renders new scraper form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => scrapers_path, :method => "post" do
      assert_select "input#scraper_name", :name => "scraper[name]"
      assert_select "input#scraper_url_id", :name => "scraper[url_id]"
      assert_select "input#scraper_site_id", :name => "scraper[site_id]"
      assert_select "input#scraper_rule_id", :name => "scraper[rule_id]"
    end
  end
end
