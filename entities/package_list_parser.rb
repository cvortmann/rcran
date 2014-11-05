require 'dcf'

class PackageListParser
  def initialize(downloader)
    @downloader = downloader
  end

  def parse
    @downloader.download.split("\n\n").map do |package|
      parsed = Dcf.parse(package).first
      { name: parsed["Package"], number: parsed["Version"] }
    end
  end
end
