require 'spec_helper'

describe "scrapers/index" do
  before(:each) do
    assign(:scrapers, [
      stub_model(Scraper,
        :name => "Name",
        :url_id => 1,
        :site_id => 2,
        :rule_id => 3
      ),
      stub_model(Scraper,
        :name => "Name",
        :url_id => 1,
        :site_id => 2,
        :rule_id => 3
      )
    ])
  end

  it "renders a list of scrapers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
