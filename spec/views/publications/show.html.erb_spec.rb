require 'rails_helper'

RSpec.describe "publications/show", :type => :view do
  before(:each) do
    @publication = Publication.create!(
      :title => "Title",
      :date => "Date"
    )
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Date/)
  end
end
