require 'open-uri'

class PackageListDownloader
  def download
    packages_file = URI.parse("http://cran.r-project.org/src/contrib/PACKAGES").open
    packages_file.read
  end
end
