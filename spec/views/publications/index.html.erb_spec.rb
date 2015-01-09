require 'rails_helper'

RSpec.describe "publications/index", :type => :view do
  before(:each) do
    assign(:publications, [
      Publication.create!(
        :title => "Title",
        :date => "Date"
      ),
      Publication.create!(
        :title => "Title",
        :date => "Date"
      )
    ])
  end

  it "renders a list of publications" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Date".to_s, :count => 2
  end
end
