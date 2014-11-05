require 'open-uri'

class PackageListDownloader
  def download
    URI.parse("http://cran.r-project.org/src/contrib/PACKAGES").open
  end
end
