class TarGzDownloader
  def initialize(package)
    @name   = package[:name]
    @number = package[:number]
  end

  def download
    URI.parse("http://cran.r-project.org/src/contrib/#{@name}_#{@number}.tar.gz").open
  end
end
