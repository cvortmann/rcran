require './entities/package_list_downloader'
require './entities/package_list_parser'
require './entities/version_saver'

class GetPackageNamesAndVersionsJob
  def run
    downloader = PackageListDownloader.new
    versions = PackageListParser.new(downloader).parse

    VersionSaver.new(versions).save
  end
end
