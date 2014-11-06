require 'open-uri'

OpenURI::Buffer.send :remove_const, 'StringMax' if OpenURI::Buffer.const_defined?('StringMax')
OpenURI::Buffer.const_set 'StringMax', 0

class TarGzDownloader
  def initialize(package)
    @name   = package[:name]
    @number = package[:number]
  end

  def download
    URI.parse("http://cran.r-project.org/src/contrib/#{@name}_#{@number}.tar.gz").open
  end
end
