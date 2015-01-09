require 'rails_helper'

RSpec.describe "publications/new", :type => :view do
  before(:each) do
    assign(:publication, Publication.new(
      :title => "MyString",
      :date => "MyString"
    ))
  end

  it "renders new publication form" do
    render

    assert_select "form[action=?][method=?]", publications_path, "post" do

      assert_select "input#publication_title[name=?]", "publication[title]"

      assert_select "input#publication_date[name=?]", "publication[date]"
    end
  end
end
