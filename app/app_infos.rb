
class AppInfos

  def self.get
    {links: Link.count}
  end

end