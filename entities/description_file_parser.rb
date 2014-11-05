require 'dcf'

class DescriptionFileParser
  def initialize(file)
    @file = file
  end

  def parse
    parsed = Dcf.parse(@file).first
    {
      name: parsed["Package"],
      title: parsed["Title"],
      number: parsed["Version"],
      author: parsed["Author"],
      maintainer: parsed["Maintainer"],
      description: parsed["Description"],
      date_of_publication: parsed["Date/Publication"]
    }
  end
end
