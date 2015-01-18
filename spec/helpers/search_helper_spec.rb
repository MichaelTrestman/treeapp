require 'rails_helper'
require 'faker'
require "search_helper"
# Specs in this file have access to a helper object that includes
# the PublicationsHelper. For example:

RSpec.describe "SearchHelper", :type => :helper do
  before :all do
    Author.delete_all
    Publication.delete_all

    authbob = Author.create({first_name: 'Bob', last_name: 'McBob'})

    100.times do
      pub = Publication.create({title: Faker::Lorem.word, citation_count: rand(1000), year: ( rand(30) + 1985 ).to_s})
      rand(3).times do
        if rand(10) > 5
          auth = Author.create({first_name: Faker::Lorem.word, last_name: Faker::Lorem.word})
          pub.authors << auth
          pub.save
          auth.publications << pub
          auth.save
        else
          pub.authors << authbob
          pub.save
          authbob.publications << pub
          authbob.save
        end
      end
    end


    Publication.create({title: "consciousness blah blah", citation_count: rand(1000)})
    Publication.create({title: "adsf;lkadjsf Consciousness asdf", citation_count: rand(1000)})
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

    it "filters titles of publications" do
      this_pubbers = Publication.complex_search({:title => 'consciousness'})
      expect(this_pubbers.all?{|pub| pub.title.downcase.include?('consciousness') }).to be true
      expect(this_pubbers.count).to be 2
    end

    it "filters dates of publications" do
      this_pubbers = Publication.complex_search({:date_start => 1990})
      p this_pubbers
      20.times do
        expect(this_pubbers.sample.year >= 1990).to be true
      end
      this_pubbers = Publication.complex_search({:date_end => '2001'})
      20.times do
        expect(this_pubbers.sample.year <= 2001).to be true
      end
    end

    it "filters authors of publications" do

      this_pubbers = Publication.complex_search({:author => "McBob"})
      # debugger
      expect(this_pubbers.count).to eq Author.where({last_name: 'McBob'})[0].publications.count


      puts "bobobobobobobobob"
      p "results count (should be bob's pubs)"
      puts this_pubbers.count

      p "should be McBob"
      puts Author.where({last_name: 'McBob'})[0].last_name

      p "should be bob's pub count, same as earlier"
      puts Author.where({last_name: 'McBob'})[0].publications.count
    end

    it "sorts by citation count" do
      this_pubbers = Publication.complex_search({}, 'citations-desc')
      20.times do
        i = rand(this_pubbers.count - 1 )
        expect(this_pubbers[i].citation_count >= this_pubbers[i+1].citation_count ).to be true
      end
    end


  end
end
