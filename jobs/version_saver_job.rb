require './entities/tar_gz_downloader'
require './entities/description_file_unpacker'
require './entities/description_file_parser'
require './entities/version'

class VersionSaverJob
  def initialize(package)
    @package = package
  end

  def run
    tar_gz = TarGzDownloader.new(@package).download
    description_file = DescriptionFileUnpacker.new(tar_gz).unpack
    Version.create(DescriptionFileParser.new(description_file).parse)
  end
end
