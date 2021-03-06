\name{addMetadata}
\alias{addMetadata}
\title{
    Add metadata of the GRanges objects used for findOverlapsOfPeaks
}
\description{
    Add metadata to to overlapping peaks after calling findOverlapsOfPeaks.
}
\usage{
addMetadata(ol, colNames=NULL, FUN=c, ...)
}
\arguments{
  \item{ol}{
    An object of overlappingPeaks, which is output of \link{findOverlapsOfPeaks}.
}
  \item{colNames}{
    Names of metadata column to be added. If it is NULL, addMetadata will guess what to add.
}
  \item{FUN}{
    A function to be called
}
  \item{...}{
    Arguments to the function call.
}
}

\value{
    return value is An object of \link{overlappingPeaks}. 
}

\author{
Jianhong Ou
}

\seealso{
    See Also as \code{\link{findOverlapsOfPeaks}}
}
\examples{
peaks1 <- GRanges(seqnames=c(6,6,6,6,5),
                 IRanges(start=c(1543200,1557200,1563000,1569800,167889600),
                         end=c(1555199,1560599,1565199,1573799,167893599),
                         names=c("p1","p2","p3","p4","p5")),
                 strand="+",
                 score=1:5, id=letters[1:5])
peaks2 <- GRanges(seqnames=c(6,6,6,6,5),
                  IRanges(start=c(1549800,1554400,1565000,1569400,167888600),
                          end=c(1550599,1560799,1565399,1571199,167888999),
                          names=c("f1","f2","f3","f4","f5")),
                  strand="+",
                  score=6:10, id=LETTERS[1:5])
ol <- findOverlapsOfPeaks(peaks1, peaks2)
addMetadata(ol)
}

\keyword{ misc }