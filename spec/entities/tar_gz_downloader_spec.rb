require './spec/spec_helper'
require './entities/tar_gz_downloader'

describe TarGzDownloader do
  let(:package)    { { name: 'x', number: '1.2.3'} }
  let(:uri) { double }
  let(:downloader) { described_class.new(package)  }

  describe "#download" do
    it "call cran website to get tar gz package for the given package" do
    expect(URI).to receive(:parse)
                   .with("http://cran.r-project.org/src/contrib/x_1.2.3.tar.gz")
                   .and_return(uri)
    expect(uri).to receive(:open)
                   .and_return(:io_object)
    expect(downloader.download).to eq(:io_object)
    end
  end
end
