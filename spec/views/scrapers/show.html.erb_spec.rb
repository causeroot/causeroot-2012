require 'spec_helper'

describe "scrapers/show" do
  before(:each) do
    @scraper = assign(:scraper, stub_model(Scraper,
      :name => "Name",
      :url_id => 1,
      :site_id => 2,
      :rule_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
