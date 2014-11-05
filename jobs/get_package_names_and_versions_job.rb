require './entities/package_list_downloader'
require './entities/package_list_parser'
require './entities/version_saver'

class GetPackageNamesAndVersionsJob
  def run
    downloader = PackageListDownloader.new
    list_of_packages = PackageListParser.new(downloader).parse

    VersionSaver.new(list_of_packages).save
  end
end
