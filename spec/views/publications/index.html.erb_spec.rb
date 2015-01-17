require 'rails_helper'

RSpec.describe "publications/index", :type => :view do
  before(:each) do
    assign(:publications, [
      Publication.create!(
        :title => "Title1",
        :date => "Date1"
      ),
      Publication.create!(
        :title => "Title2",
        :date => "Date2"
      )
    ])
  end

  it "renders a list of publications" do
    render
    expect(rendered).to match(/Title1/)
    expect(rendered).to match(/Title2/)
    expect(rendered).to match(/Date1/)
    expect(rendered).to match(/Date2/)

  end
end
