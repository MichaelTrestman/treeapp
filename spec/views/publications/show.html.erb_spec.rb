require 'rails_helper'

RSpec.describe "publications/show", :type => :view do
  before(:each) do
    @publication = Publication.create(
      :title => "Title",
      :year => 666
    )
    @publication.authors << Author.create({last_name: 'mcbob'})
    @authors = @publication.authors
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Date/)
  end
end
