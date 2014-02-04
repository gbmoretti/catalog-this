require_relative 'redis_client'

class Link
  attr_reader :title, :keywords, :site, :url


  def self.find(url)
    client = RedisClient.get_instance
    parsed_link = client.get(url)
    self.new(parsed_link) if parsed_link
    false
  end

  def self.create(url,parsed_link)
    client = RedisClient.get_instance
    client.set(url,parsed_link)
    self.new(url,parsed_link)
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
    @redis ||= RedisClient.get_instance
  end

end