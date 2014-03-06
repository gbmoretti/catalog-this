class RedisClient

  def self.get_instance
    @@instance = self.new
  end

  def initialize
    @client ||= Redis.new(redis_conf)
  end

  def set(name,data)
    @client.set(name,data.to_json)
  end

  def get(name)
    rs = @client.get(name)
    JSON.parse(rs) unless rs.nil?
    return false
  end

  private
  def redis_conf
    #https://devcenter.heroku.com/articles/rediscloud
    uri = URI.parse(ENV["REDISCLOUD_URL"])
    {:host => uri.host, :port => uri.port, :password => uri.password}
  end

end