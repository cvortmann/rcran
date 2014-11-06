require './spec/spec_helper'
require './jobs/download_versions_job'

describe DownloadVersionsJob do
  before do
    allow(URI).to receive(:parse)
                  .with("http://cran.r-project.org/src/contrib/PACKAGES")
                  .and_return(double(:uri, open: File.open("./spec/files/PACKAGES")))
    allow(URI).to receive(:parse)
                  .with("http://cran.r-project.org/src/contrib/A3_0.9.2.tar.gz")
                  .and_return(double(:uri, open: File.open("./spec/files/A3_0.9.2.tar.gz")))
    allow(URI).to receive(:parse)
                  .with("http://cran.r-project.org/src/contrib/abc_2.0.tar.gz")
                  .and_return(double(:uri, open: File.open("./spec/files/abc_2.0.tar.gz")))
    allow(URI).to receive(:parse)
                  .with("http://cran.r-project.org/src/contrib/abcdeFBA_0.4.tar.gz")
                  .and_return(double(:uri, open: File.open("./spec/files/abcdeFBA_0.4.tar.gz")))
  end

  let(:job) { described_class.new }

  describe "#run" do
    context "when there's no version in the db" do
      it "saves one entry per file" do
        job.run

        expect(Version.count).to eq(3)
      end
    end

    context "when there a already version in the db" do
      before do
        Version.create(name: 'abc', number: '2.0', title: 'old title')
      end

      it "saves one entry per file and don't update the existin version" do
        expect(Version.count).to eq(1)

        job.run

        expect(Version.count).to eq(3)
        expect(Version.find_by(name: 'abc', number: '2.0').title).to eq('old title')
      end
    end
  end
end
