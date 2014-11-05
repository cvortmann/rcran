require './entities/version'

class VersionSaver
  def initialize(packages, limit = packages.length)
    @packages = packages
    @limit = limit
  end

  def save
    @packages[0...@limit].each { |package| Version.find_or_create_by(name: package["Package"], number: package["Version"]) }
  end
end
