require './spec/spec_helper'
require './jobs/version_saver_job'

describe VersionSaverJob do
  let(:package) { { name: 'x', version: '1.0'} }
  let(:job)     { described_class.new(package) }
  let(:name)    { "A3" }
  let(:version_to_be_saved) do
    {
      name: name,
      title: "A3: Accurate, Adaptable, and Accessible Error Metrics for Predictive Models",
      number: "0.9.2",
      author: "Scott Fortmann-Roe",
      maintainer: "Scott Fortmann-Roe <scottfr@berkeley.edu>",
      description: "This package supplies tools for tabulating and analyzing the results of predictive models. The methods employed are applicable to virtually any predictive model and make comparisons between different methodologies straightforward.",
      date_of_publication: "2013-03-26 19:58:40"
    }
  end

  before do
    expect(TarGzDownloader).to receive(:new).with(package).and_return(double(:downloader, download: :tar_gz))
    expect(DescriptionFileUnpacker).to receive(:new).with(:tar_gz).and_return(double(:unpacker, unpack: :description_file))
    expect(DescriptionFileParser).to receive(:new).with(:description_file).and_return(double(:parser, parse: version_to_be_saved))
  end

  it "should save parsed version to db" do
    job.run

    version = Version.first
    expect(version.name).to                eq("A3")
    expect(version.title).to               eq("A3: Accurate, Adaptable, and Accessible Error Metrics for Predictive Models")
    expect(version.number).to              eq("0.9.2")
    expect(version.author).to              eq("Scott Fortmann-Roe")
    expect(version.maintainer).to          eq("Scott Fortmann-Roe <scottfr@berkeley.edu>")
    expect(version.description).to         eq("This package supplies tools for tabulating and analyzing the results of predictive models. The methods employed are applicable to virtually any predictive model and make comparisons between different methodologies straightforward.")
    expect(version.date_of_publication).to eq("2013-03-26 19:58:40")
  end

  context "parsed version contains a character that can't be converted to utf-8" do
    let(:name) { "\xE9".force_encoding(Encoding::ASCII_8BIT) }

    it "should not save parsed" do
      job.run
      expect(Version.count).to eq(0)
    end
  end
end
