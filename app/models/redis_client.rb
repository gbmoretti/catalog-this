require 'singleton'

class RedisClient
  include Singleton

  def set(name,data)
    client.set(name,data.to_json)
  end

  def get(name)
    rs = client.get(name)
    return JSON.parse(rs) unless rs.nil?
    return false
  end

  def count_keys(prefix='*')
    keys(prefix).count
  end

  def keys(prefix='*')
    client.keys(prefix + '*')
  end

  def exists(key)
    client.exists(key)
  end

  private
  def redis_conf
    #https://devcenter.heroku.com/articles/rediscloud
    uri = URI.parse(ENV["REDISCLOUD_URL"])
    {:host => uri.host, :port => uri.port, :password => uri.password}
  end

  def client
    @client ||= Redis.new(redis_conf)
    @client
  end

end
