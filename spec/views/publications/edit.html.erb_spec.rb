require 'rails_helper'

RSpec.describe "publications/edit", :type => :view do
  before(:each) do
    @publication = assign(:publication, Publication.create!(
      :title => "MyString",
      :date => "MyString"
    ))
  end

  it "renders the edit publication form" do
    render

    assert_select "form[action=?][method=?]", publication_path(@publication), "post" do

      assert_select "input#publication_title[name=?]", "publication[title]"

      assert_select "input#publication_date[name=?]", "publication[date]"
    end
  end
end
