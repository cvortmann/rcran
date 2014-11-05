require './entities/version'

class PackageListFilter
  def initialize(list)
    @list = list
  end

  def remove_existing_versions
    @list.reject { |e| Version.where(name: e[:name], number: e[:number]).exists? }
  end
end
