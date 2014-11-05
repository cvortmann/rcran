require './spec/spec_helper'
require './entities/package_list_parser'

describe PackageListParser do
  let(:file)       { File.read("./spec/files/PACKAGES")  }
  let(:downloader) { double(:downloader, download: file) }
  let(:parser) { described_class.new(downloader) }

  describe "#parse" do
    it "should extract package names from file" do
      packages = parser.parse

      expect(packages.map {|e| e[:name] }).to   eq(["A3", "abc", "abcdeFBA"])
      expect(packages.map {|e| e[:number] }).to eq(["0.9.2", "2.0", "0.4"])
    end
  end
end
