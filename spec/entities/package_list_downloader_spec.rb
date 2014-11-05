require './spec/spec_helper'
require './entities/package_list_downloader'

describe PackageListDownloader do
  let(:downloader) { described_class.new }
  let(:uri) { double }

  it "call cran website to get the list of packages" do
    expect(URI).to receive(:parse).with("http://cran.r-project.org/src/contrib/PACKAGES").and_return(uri)
    expect(uri).to receive(:open).and_return(:downloaded_list)
    expect(downloader.download).to eq(:downloaded_list)
  end
end
