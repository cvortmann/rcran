require './entities/package_list_downloader'
require './entities/package_list_parser'
require './entities/package_list_filter'
require './jobs/version_saver_job'
require 'celluloid/autostart'

class DownloadVersionsJob
  def run
    downloader = PackageListDownloader.new
    list_of_packages = PackageListParser.new(downloader).parse
    filtered_list = PackageListFilter.new(list_of_packages).remove_existing_versions
    pool = VersionSaverJob.pool(size: 40)
    filtered_list.map { |package| pool.future.run(package) }.map(&:value)
  end
end
