require './entities/package_list_downloader'
require './entities/package_list_parser'
require './entities/package_list_filter'
require './jobs/version_saver_job'

class DownloadVersionsJob
  def run
    downloader = PackageListDownloader.new
    list_of_packages = PackageListParser.new(downloader).parse

    filtered_list = PackageListFilter.new(list_of_packages).remove_existing_versions

    filtered_list.each { |package| VersionSaverJob.new(package).run }
  end
end
