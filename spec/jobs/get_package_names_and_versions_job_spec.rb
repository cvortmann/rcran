require './spec/spec_helper'
require './jobs/get_package_names_and_versions_job'

describe GetPackageNamesAndVersionsJob do
  before do
    allow(URI).to receive(:parse)
                  .with("http://cran.r-project.org/src/contrib/PACKAGES")
                  .and_return(double(:uri, open: File.open("./spec/files/PACKAGES")))
  end

  let(:job) { described_class.new }

  describe "#run" do
    it "downloads the package file and save a package and version per entry" do
      job.run

      expect(Version.count).to eq(3)
    end

    it "saves only the number of packages set by the environment variable" do
      ENV['NUMBER_OF_PACKAGES'] = "2"

      job.run

      expect(Version.count).to eq(2)
    end
  end
end
