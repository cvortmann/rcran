require './spec/spec_helper'
require './entities/package_list_parser'

describe PackageListParser do
  let(:file)       { File.read("./spec/files/PACKAGES")  }
  let(:downloader) { double(:downloader, download: file) }
  let(:parser) { described_class.new(downloader) }

  describe "#parse" do
    it "should extract package names from file" do
      packages = parser.parse

      expect(packages[0]["Package"]).to eq("A3")
      expect(packages[0]["Version"]).to eq("0.9.2")

      expect(packages[1]["Package"]).to eq("abc")
      expect(packages[1]["Version"]).to eq("2.0")

      expect(packages[2]["Package"]).to eq("abcdeFBA")
      expect(packages[2]["Version"]).to eq("0.4")
    end
  end
end
