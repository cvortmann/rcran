require './entities/package_list_downloader'
require './entities/package_list_parser'
require './entities/version_saver'

class GetPackageNamesAndVersionsJob
  def run
    downloader = PackageListDownloader.new
    versions = PackageListParser.new(downloader).parse

    limit = ENV["NUMBER_OF_PACKAGES"] || versions.size

    VersionSaver.new(versions, limit.to_i).save
  end
end
