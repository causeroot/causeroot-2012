require 'spec_helper'

describe "rules/index" do
  before(:each) do
    assign(:rules, [
      stub_model(Rule,
        :name => "Name",
        :type => "Type",
        :xpath => "Xpath",
        :regex => "Regex",
        :field_name => "Field Name",
        :rule_id => 1
      ),
      stub_model(Rule,
        :name => "Name",
        :type => "Type",
        :xpath => "Xpath",
        :regex => "Regex",
        :field_name => "Field Name",
        :rule_id => 1
      )
    ])
  end

  it "renders a list of rules" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Xpath".to_s, :count => 2
    assert_select "tr>td", :text => "Regex".to_s, :count => 2
    assert_select "tr>td", :text => "Field Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
