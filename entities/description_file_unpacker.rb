require 'rubygems/package'
require 'zlib'

class DescriptionFileUnpacker
  def initialize(tar_gz)
    @tar_gz = tar_gz
  end

  def unpack
    Zlib::GzipReader.open(@tar_gz) do |gz|
      tar_extract = Gem::Package::TarReader.new(gz)
      tar_extract.find { |f| f.full_name =~ /DESCRIPTION/ }.read
    end
  end
end
