\name{binOverFeature}
\alias{binOverFeature}
\title{
Aggregate peaks over bins from the TSS
}
\description{
Aggregate peaks over bins from the feature sites.
}
\usage{
binOverFeature(..., annotationData=GRanges(),
                    select=c("all", "nearest"),
                    radius=5000L, nbins=50L,
                    minGeneLen=1L, aroundGene=FALSE, mbins=nbins, 
                    featureSite=c("FeatureStart", "FeatureEnd", "bothEnd"),
                    PeakLocForDistance=c("all", "end","start","middle"), 
                    FUN=sum, errFun=sd, xlab, ylab, main)
}
\arguments{
  \item{\dots}{
    Objects of GRanges to be analyzed
}
  \item{annotationData}{
    An object of \link[GenomicRanges]{GRanges} or \link{annoGR} for annotation
}
  \item{select}{
    Logical: annotate the peaks to all features or the nearest one
}
  \item{radius}{
    The radius of the longest distance to feature site
}
  \item{nbins}{
    The number of bins
}
  \item{minGeneLen}{
    The minimal gene length
}
  \item{aroundGene}{
    Logical: count peaks around features or a given site of the features. 
    Default = FALSE
}
  \item{mbins}{
    if aroundGene set as TRUE, the number of bins intra-feature.
    The value will be normalized by value * (radius/genelen) * (mbins/nbins) 
}
  \item{featureSite}{
    which site of features should be used for distance calculation
}
  \item{PeakLocForDistance}{
    which site of peaks should be used for distance calculation
}
  \item{FUN}{
    the function to be used for score calculation
}
  \item{errFun}{
    the function to be used for errorbar calculation or values for the errorbar.
}
  \item{xlab}{
    titles for each x axis
}
  \item{ylab}{
    titles for each y axis
}
  \item{main}{
    overall titles for each plot
}
}
\value{
 A data.frame with bin values.
}
\author{
Jianhong Ou
}
\examples{
bed <- system.file("extdata", "MACS_output.bed", package="ChIPpeakAnno")
gr1 <- toGRanges(bed, format="BED", header=FALSE)
data(TSS.human.GRCh37)
binOverFeature(gr1, annotationData=TSS.human.GRCh37,
               radius=5000, nbins=10, FUN=length, errFun=0)
}
\keyword{ misc }
