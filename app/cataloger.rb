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

  def initialize
  end

end