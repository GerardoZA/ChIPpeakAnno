\name{IDRfilter}
\alias{IDRfilter}
\title{
Filter peaks by IDR (irreproducible discovery rate)
}
\description{
Using IDR to assess the consistency of replicate experiments and obtain a high-confidence single set of peaks
}
\usage{
IDRfilter(peaksA, peaksB, bamfileA, bamfileB, 
          maxgap=0L, minoverlap=1L, singleEnd=TRUE,
          IDRcutoff=0.01, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{peaksA, peaksB}{
    peaklist, \link[GenomicRanges]{GRanges} object.
}
  \item{bamfileA, bamfileB}{
    file path of bam files.
}
  \item{maxgap}{
    Non-negative integer. Peak intervals with a separation of maxgap or less are considered to be overlapped.
}
  \item{minoverlap}{
    Non-negative integer. Peak intervals with an overlapping of minoverlap or more are considered to be overlapped.
}
  \item{singleEnd}{
    (Default TRUE) A logical indicating if reads are single or paired-end. 
}
  \item{IDRcutoff}{
    If the IDR no less than IDRcutoff, the peak will be removed.
}
  \item{...}{
    Not used.
}

}

\value{
    An object GRanges
}
\references{
    Li, Qunhua, et al. "Measuring reproducibility of high-throughput experiments." The annals of applied statistics (2011): 1752-1779.
}
\author{
    Jianhong Ou
}
\examples{
  if(interactive()){
    library(MMDiffBamSubset)
    peaksA=toGRanges(WT.AB2.Peaks(), format="MACS")
    peaksB=toGRanges(Resc.AB2.Peaks(), format="MACS")
    bamfileA=WT.AB2()
    bamfileB=Resc.AB2()
    IDRfilter(peaksA, peaksB,
              bamfileA, bamfileB)
  }
}

\keyword{ misc }
