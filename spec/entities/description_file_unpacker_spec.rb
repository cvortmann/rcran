require './spec/spec_helper'
require './entities/description_file_unpacker'

describe DescriptionFileUnpacker do
  let(:tar_gz)   { File.open("./spec/files/A3_0.9.2.tar.gz") }
  let(:unpacker) { described_class.new(tar_gz) }

  describe "#unpack" do
    it "should return the DESCRIPTION file inside the tar.gz file" do
      description_contents = <<DESCRIPTION
Package: A3
Type: Package
Title: A3: Accurate, Adaptable, and Accessible Error Metrics for
        Predictive Models
Version: 0.9.2
Date: 2013-03-24
Author: Scott Fortmann-Roe
Maintainer: Scott Fortmann-Roe <scottfr@berkeley.edu>
Description: This package supplies tools for tabulating and analyzing
        the results of predictive models. The methods employed are
        applicable to virtually any predictive model and make
        comparisons between different methodologies straightforward.
License: GPL (>= 2)
Depends: R (>= 2.15.0), xtable, pbapply
Suggests: randomForest, e1071
Packaged: 2013-03-26 18:58:12 UTC; scott
NeedsCompilation: no
Repository: CRAN
Date/Publication: 2013-03-26 19:58:40
DESCRIPTION

      expect(unpacker.unpack).to eq(description_contents)
    end
  end
end
