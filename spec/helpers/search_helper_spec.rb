require 'rails_helper'
require 'faker'
require "search_helper"
# Specs in this file have access to a helper object that includes
# the PublicationsHelper. For example:

RSpec.describe SearchHelper, :type => :helper do
  before :all do
    Publication.delete_all
    assign(:publications, Array.new(100).map { |x|
      Publication.create({title: Faker::Lorem.word})

    })
      Publication.create({title: "consciousness blah blah"})
  end

  describe "#complex_search" do
    it "runs" do
      this_pubbers = Publication.complex_search({}) .sort { |a, b| a.id <=> b.id }
      that_pubbers = Publication.all.sort { |a, b| a.id <=> b.id }
      counter = this_pubbers.length - 1
      while counter >= 0 do
        expect(this_pubbers[counter]).to eq that_pubbers[counter]
        counter -= 1
      end
    end

    it "sorts titles of publications" do
      this_pubbers = Publication.complex_search({:title => 'consciousness'})
      expect(this_pubbers.all?{|pub| pub.title.include?('consciousness') }).to be true
      expect(this_pubbers.count > 0).to be true
    end
  end
end
