require_relative 'redis_client'

class Link
  attr_reader :title, :keywords, :site, :url

  PREFIX = 'link::'

  def self.find(url)
    parsed_link = RedisClient.instance.get(PREFIX + url)
    return self.new(parsed_link) if parsed_link
    false
  end

  def self.create(url,parsed_link)
    RedisClient.instance.set(PREFIX + url,parsed_link)
    self.new(url,parsed_link)
  end

  def self.count
    RedisClient.instance.count_keys(PREFIX)
  end

  def self.find_by_params(params)
    keys = RedisClient.instance.keys(PREFIX)
    links = []
    keys.each do |key|
      link = RedisClient.instance.get(key)
      params.each do |param,value|
        unless link[param].nil?
          links << link if link[param] =~ Regexp.new(value)
        end
      end
    end
    links.map { |l| self.new(l['url'],l) }
  end

  def initialize(url,resource)
    @url = url
    @title = resource['title']
    @keywords = 'wip'
    @site = resource['site']
  end

  def to_json(args)
    JSON.generate({
      title: @title,
      url: @url,
      keywords: @keywords,
      site: @site
    })
  end

  private
  def client
    RedisClient.instance
  end

end
