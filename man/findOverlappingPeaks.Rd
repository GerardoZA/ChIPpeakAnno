\name{findOverlappingPeaks}
\alias{findOverlappingPeaks}
\alias{findOverlappingPeaks-deprecated}
\title{
Find the overlapping peaks for two peak ranges.
}
\description{
Find the overlapping peaks for two input peak ranges.

This function is to keep the backward compatibility with previous versions for 
RangedData object.

The new function findOverlapsOfPeaks is recommended. 

Convert RangedData to GRanges with toGRanges function.
}
\usage{
findOverlappingPeaks(Peaks1, Peaks2, maxgap = 0L,
    minoverlap=1L, multiple = c(TRUE, FALSE), 
    NameOfPeaks1 = "TF1", NameOfPeaks2 = "TF2",
    select=c("all", "first","last","arbitrary"), annotate = 0,
    ignore.strand=TRUE, 
    connectedPeaks=c("min", "merge"), \dots)
}
\arguments{
  \item{Peaks1}{
RangedData: See example below.
}
  \item{Peaks2}{
RangedData: See example below.
}
  \item{maxgap}{
Non-negative integer. Intervals with a separation of maxgap or less are 
considered to be overlapping.
}
\item{minoverlap}{
Non-negative integer. Intervals with an overlapping of minoverlap or more are 
considered to be overlapping.
}
  \item{multiple}{
TRUE or FALSE: TRUE may return multiple overlapping peaks in Peaks2 for one 
peak in Peaks1; FALSE will return at most one overlapping peaks in Peaks2 for 
one peak in Peaks1. This parameter is kept for backward compatibility, 
please use select.
}
  \item{NameOfPeaks1}{
Name of the Peaks1, used for generating column name.
}
  \item{NameOfPeaks2}{
Name of the Peaks2, used for generating column name.
}
\item{select}{
all may return multiple overlapping peaks, first will return the first 
overlapping peak, last will return the last overlapping peak and arbitrary 
will return one of the overlapping peaks.
}
\item{annotate}{
Include overlapFeature and shortestDistance in the OverlappingPeaks or not. 
1 means yes and 0 means no. Default to 0.
}
\item{ignore.strand}{
    When set to TRUE, the strand information is ignored in the overlap 
    calculations.
  }
\item{connectedPeaks}{
  If multiple peaks involved in overlapping in several groups, set it to 
  "merge" will count it as only 1, while set it to "min" will count it as 
  the minimal involved peaks in any concered groups 
}
\item{\dots}{
    Objects of \link[GenomicRanges:GRanges]{GRanges} or 
    \link[IRanges:RangedData]{RangedData}: 
    See also \code{\link{findOverlapsOfPeaks}}.
}
}
\details{
Efficiently perform overlap queries with an interval tree implemented in 
IRanges.
}
\value{
  \item{OverlappingPeaks}{a data frame consists of input peaks information with
  added information: overlapFeature (upstream: peak1 resides upstream of the 
  peak2; downstream: peak1 resides downstream of the peak2; inside: peak1 
  resides inside the peak2 entirely; overlapStart: peak1 overlaps with the 
  start of the peak2; overlapEnd: peak1 overlaps with the end of the peak2;
  includeFeature: peak1 include the peak2 entirely) and shortestDistance 
  (shortest distance between the overlapping peaks)}
  \item{MergedPeaks}{RangedData contains merged overlapping peaks}
}
\references{
1.Interval tree algorithm from: Cormen, Thomas H.; Leiserson, Charles E.; 
Rivest, Ronald L.; Stein, Clifford. Introduction to Algorithms, second edition,
MIT Press and McGraw-Hill. ISBN 0-262-53196-8

2.Zhu L.J. et al. (2010) ChIPpeakAnno: a Bioconductor package to annotate 
ChIP-seq and ChIP-chip data. BMC Bioinformatics 2010, 11:237
doi:10.1186/1471-2105-11-237

3. Zhu L (2013). Integrative analysis of ChIP-chip and ChIP-seq dataset. 
In Lee T and Luk ACS (eds.), Tilling Arrays, volume 1067, chapter 4, pp. -19. 
Humana Press. http://dx.doi.org/10.1007/978-1-62703-607-8_8}
\author{
Lihua Julie Zhu
}

\seealso{
    findOverlapsOfPeaks, annotatePeakInBatch, makeVennDiagram
}
\examples{
    if (interactive())
    {    
    peaks1 = 
        RangedData(IRanges(start=c(1543200,1557200,1563000,1569800,167889600),
                           end=c(1555199,1560599,1565199,1573799,167893599),
                           names=c("p1","p2","p3","p4","p5")),
                   strand=as.integer(1),space=c(6,6,6,6,5))
    peaks2 = 
        RangedData(IRanges(start=c(1549800,1554400,1565000,1569400,167888600),
                           end=c(1550599,1560799,1565399,1571199,167888999),
                           names=c("f1","f2","f3","f4","f5")),
                   strand=as.integer(1),space=c(6,6,6,6,5))
    t1 =findOverlappingPeaks(peaks1, peaks2, maxgap=1000, 
          NameOfPeaks1="TF1", NameOfPeaks2="TF2", select="all", annotate=1) 
    r = t1$OverlappingPeaks
    pie(table(r$overlapFeature))
    as.data.frame(t1$MergedPeaks)
    }
}
\keyword{ misc }
