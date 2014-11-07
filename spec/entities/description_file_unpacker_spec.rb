require './spec/spec_helper'
require './entities/description_file_unpacker'

describe DescriptionFileUnpacker do
  let(:unpacker) { described_class.new(tar_gz) }

  describe "#unpack" do
    context "when tar_gz does not contain another DESCRIPTION file" do
      let(:tar_gz)   { File.open("./spec/files/A3_0.9.2.tar.gz") }

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

    context "when tar_gz contain another DESCRIPTION file" do
      let(:tar_gz) { File.open("./spec/files/copBasic_1.6.0.tar.gz") }

      it "should return the DESCRIPTION file inside the tar.gz file" do
        description_contents = <<DESCRIPTION
Package: copBasic
Title: Basic Theoretical Copula, Empirical Copula, and Various Utility
        Functions
Version: 1.6.0
Date: 2014-09-26
Author: William Asquith
Description: The package implements extensive functions for copula computations and related mathematical operations oriented around the oft cited and fundamental copula theory described by Nelson (2006). The lower (W), upper (M), product (P), PSP, and Plackett (with parameter estimation) copulas are provided. Individual copula functional support is intentionally limited to keep the package focused on an API to general copula theory. Expressions available for an arbitrary copula include the diagonal of a copula, the survival copula, the dual of a copula, and co-copula. Level curves (sets) are available. Horizontal and vertical copula sections and derivatives of such sections also are supported. The numerical derivatives of a copula are provided as well as inverses, and thus functions for copula simulation also are supported. Composition of copulas is provided: (1) composition of a single copula using two composition parameters, (2) composition of two copulas using two composition parameters, (3) composition of two copulas using four composition parameters, and (4) composite copula random variates.  Characteristics of copulas include Kendall Tau, Spearman Rho, Gini Gamma, Blomqvist Beta, and Schweizer-Wolff Sigma. Logical evaluators of positively/negatively quadrant dependency, left-tail decreasing, and right-tail increasing also are available. Quantile and median regression for V with respect to U and U with respect to V is available. Empirical copulas (EC) are supported. ECs are dependent on gridded data structures for which generation capability is provided. The derivatives of the EC grid are computable. Also, the inverses of the derivatives, which are the conditional QDFs of copula sections also are computable. Median and quantile regression of an EC also is supported along with support for EC simulation of V conditional on U.
Maintainer: William Asquith <william.asquith@ttu.edu>
Repository: CRAN
Depends: R (>= 2.10)
Imports: lmomco
License: GPL-2
NeedsCompilation: no
Packaged: 2014-09-26 12:27:20 UTC; wasquith
Date/Publication: 2014-09-26 16:53:11
DESCRIPTION

        expect(unpacker.unpack).to eq(description_contents)
      end
    end

    context "when tar_gz contain a DESCRIPTION file with a extension" do
      let(:tar_gz) { File.open("./spec/files/lda_1.3.2.tar.gz") }

      it "should return the DESCRIPTION file inside the tar.gz file" do
        description_contents = <<DESCRIPTION
Package: lda
Type: Package
Title: Collapsed Gibbs sampling methods for topic models.
Version: 1.3.2
Date: 2012-05-22
Author: Jonathan Chang
Maintainer: Jonathan Chang <jonchang@fb.com>
Description: This package implements latent Dirichlet allocation (LDA)
        and related models.  This includes (but is not limited to)
        sLDA, corrLDA, and the mixed-membership stochastic blockmodel.
        Inference for all of these models is implemented via a fast
        collapsed Gibbs sampler writtten in C.  Utility functions for
        reading/writing data typically used in topic models, as well as
        tools for examining posterior distributions are also included.
License: LGPL
LazyLoad: yes
Suggests: Matrix, reshape2, ggplot2 (>= 0.9.1), penalized
Packaged: 2012-10-14 02:29:36 UTC; jonchang
Depends: R (>= 2.10)
Repository: CRAN
Date/Publication: 2012-10-14 06:49:32
DESCRIPTION

        expect(unpacker.unpack).to eq(description_contents)
      end
    end

    context "when tar_gz contain a DESCRIPTION in a inner folder" do
      let(:tar_gz) { File.open("./spec/files/devtools_1.6.1.tar.gz") }

      it "should return the DESCRIPTION file inside the tar.gz file" do
        description_contents = <<DESCRIPTION
Package: devtools
Title: Tools to make developing R code easier
Version: 1.6.1
Authors@R: as.person(c(
    "Hadley Wickham <hadley@rstudio.com> [aut, cre]",
    "Winston Chang [aut]",
    "RStudio [cph]",
    "R Core team [ctb] (Some namespace and vignette code extracted from base R)"
    ))
Description: Collection of package development tools.
Depends: R (>= 3.0.2)
Imports: httr (>= 0.4), RCurl, utils, tools, methods, memoise, whisker,
        evaluate, digest, rstudioapi, jsonlite
Suggests: testthat (>= 0.7), roxygen2 (>= 4.0.2), BiocInstaller, Rcpp
        (>= 0.10.0), MASS, rmarkdown, knitr
License: GPL (>= 2)
Packaged: 2014-10-07 18:36:53 UTC; hadley
Author: Hadley Wickham [aut, cre],
  Winston Chang [aut],
  RStudio [cph],
  R Core team [ctb] (Some namespace and vignette code extracted from base
    R)
Maintainer: Hadley Wickham <hadley@rstudio.com>
NeedsCompilation: yes
Repository: CRAN
Date/Publication: 2014-10-07 22:06:39
DESCRIPTION

        expect(unpacker.unpack).to eq(description_contents)
      end
    end
  end
end
