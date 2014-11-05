require './entities/version'

class VersionSaver
  def initialize(packages)
    @packages = packages
  end

  def save
    @packages.each { |package| Version.find_or_create_by(name:   package[:name],
                                                         number: package[:number]) }
  end
end
