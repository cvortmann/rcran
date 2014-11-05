require './spec/spec_helper'
require './entities/description_file_parser'

describe DescriptionFileParser do
  let(:file)   { File.read("./spec/files/DESCRIPTION") }
  let(:parser) { described_class.new(file) }

  it "should parse name" do
    expect(parser.parse[:name]).to eq("A3")
  end

  it "should parse title" do
    expect(parser.parse[:title]).to eq("A3: Accurate, Adaptable, and Accessible Error Metrics for Predictive Models")
  end

  it "should parse number" do
    expect(parser.parse[:number]).to eq("0.9.2")
  end

  it "should parse author" do
    expect(parser.parse[:author]).to  eq("Scott Fortmann-Roe")
  end

  it "should parse maintainer" do
    expect(parser.parse[:maintainer]).to eq("Scott Fortmann-Roe <scottfr@berkeley.edu>")
  end

  it "should parse description" do
    expect(parser.parse[:description]).to eq("This package supplies tools for tabulating and analyzing the results of predictive models. The methods employed are applicable to virtually any predictive model and make comparisons between different methodologies straightforward.")
  end

  it "should parse date_of_publication" do
    expect(parser.parse[:date_of_publication]).to eq("2013-03-26 19:58:40")
  end
end
