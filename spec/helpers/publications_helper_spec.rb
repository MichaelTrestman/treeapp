require 'rails_helper'
require 'faker'
require "publications_helper"
# Specs in this file have access to a helper object that includes
# the PublicationsHelper. For example:
#

RSpec.describe PublicationsHelper, :type => :helper do
  before do

    assign(:publications, Array.new(100).map { |x|
      Publication.create({title: Faker::Lorem.word})
    })
  end
  describe "#complex_search" do
    it "runs" do
      this_pubbers = Publication.complex_search.sort { |a, b| a.id <=> b.id }
      that_pubbers = Publication.all.sort { |a, b| a.id <=> b.id }
      counter = this_pubbers.length - 1
      while counter >= 0 do
        expect(this_pubbers[counter]).to eq that_pubbers[counter]
        counter -= 1
      end
    end
  end
end
