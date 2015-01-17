# require 'nokogiri'
# require 'open-uri'
# require 'debugger'

class Publication < ActiveRecord::Base
  extend SearchHelper
  has_many :authorships
  has_many :authors, through: :authorships

  # has_many :citations
  # has_many :references, through: :citations
  # has_many :citations
  # has_many :references, through: :citations

  # has_many :distributions
  # has_many :taxons, through: :distributions
  # has_many :tags
  # has_many :topics, through: :tags
  def self.scrape_in_a_few_citations n=1
    n.times do
      pub = Publication.where({citation_count: nil}).sample

      count = pub.scrape_scholar_for_citation_count
      sleep 3
    end

  end
  def self.seed_from_txt
    seed_txt = File.open('db/citation_count_seed.txt', 'r')
      seed_txt.each do |line|
        line = line.gsub("\n", '').split('|')
        pub = Publication.where({title: line[0], date: line[1]})[0]
        pub.citation_count = line[2]
        pub.save
      end
  end
  def self.scrape_scholar_for_citation_count
    google_scholar_url = "https://scholar.google.com/scholar?as_q=#{self.title.split(' ').join('+')}&as_epq=&as_oq=&as_eq=&as_occt=any&as_sauthors=&as_publication=&as_ylo=&as_yhi=&btnG=&hl=en&as_sdt=0%2C5"


    # google_scholar_url = "https://scholar.google.com/scholar?as_q=#{self.title.split(' ').join('+')}&as_epq=&as_oq=&as_eq=&as_occt=any&as_sauthors=#{self.authors.each{|author| author.last_name}.gsub('[', '').gsub(']', '')}&as_publication=&as_ylo=&as_yhi=&btnG=&hl=en&as_sdt=0%2C5"


    # puts google_scholar_url
    page = Nokogiri::HTML(open( google_scholar_url ))
    top_result = page.css('.gs_r')[0]
    p top_result.text

    if top_result.text.gsub('.', ' ').split('Cited by ')[1]
      citation_count = top_result.text.gsub('.', ' ').split('Cited by ')[1].split(' ')[0].to_i
    else
      citation_count = "unknown"

    end
      p citation_count
      self.citation_count = citation_count
      message = "yay just saved #{self.title} as haveing #{self.citation_count} citations" if self.save
      p message
      `say "yo"`
  end
end


