require 'spec_helper'

describe "rules/show" do
  before(:each) do
    @rule = assign(:rule, stub_model(Rule,
      :name => "Name",
      :type => "Type",
      :xpath => "Xpath",
      :regex => "Regex",
      :field_name => "Field Name",
      :rule_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Type/)
    rendered.should match(/Xpath/)
    rendered.should match(/Regex/)
    rendered.should match(/Field Name/)
    rendered.should match(/1/)
  end
end
