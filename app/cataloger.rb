require_relative 'models/link'
require_relative 'parser'

class Cataloger

  def self.catalog(url)
    parsed_link = Link.find(url)
    if parsed_link
      parsed_link
    else
      Link.create(url,Parser.parse(url))
    end
  end

  def self.search(params)
    links = Link.find_by_params(params)
  end

  def initialize
  end

end