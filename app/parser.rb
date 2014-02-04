require 'nokogiri'
require 'open-uri'

class Parser

  def self.parse(url)
    instance = self.new(url)
    instance.parsed_url
  end

  def initialize(url)
    @url = url
    @doc = open_doc
    @title = parse_title
    @site = parse_site
  end

  def parsed_url
    {
      'title' => @title,
      'site' => @site
    }
  end

  private
  def open_doc
    Nokogiri::HTML(open(@url))
  end

  def parse_title
    @doc.css('title')[0].content
  end

  def parse_site
    URI.split(@url)[2] #we need only the root uri here
  end
end