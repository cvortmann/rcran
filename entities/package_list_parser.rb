require 'dcf'

class PackageListParser
  def initialize(downloader)
    @downloader = downloader
  end

  def parse
    Dcf.parse(@downloader.download)
  end
end
