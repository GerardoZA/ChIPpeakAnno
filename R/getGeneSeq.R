getGeneSeq <- function(LocationParameters, mart){
    ### ensembl_gene_id, distanceToNearestTSS, upstream, downstream, 
    ### TSSStart, TSSEnd, mart
    if (missing(LocationParameters) || length(LocationParameters) <6)
    {
        stop("No valid LocationParameters passed in. 
             It should contain six fields as c(distanceToNearestTSS, 
             upstream, downstream, GeneStart, GeneEnd)!")
    }
    if (missing(mart) || class(mart) !="Mart")
    {
        stop("No valid mart object is passed in!")
    }
    distanceToNearestTSS = as.numeric(LocationParameters[2])
    downstream = as.numeric(LocationParameters[4])
    upstream = as.numeric(LocationParameters[3])
    TSSStart = as.numeric(LocationParameters[5])
    TSSEnd = as.numeric(LocationParameters[6])
    
    TSSLen = TSSEnd - TSSStart
    seqLen = downstream + upstream
    
    seq = getSequence(id=as.character(LocationParameters[1]), 
                      type="ensembl_gene_id",
                      seqType="gene_exon_intron",
                      mart=mart)
    if (nchar(seq[1]) < TSSLen)
    {
        upstream = upstream + TSSLen - nchar(seq[1])
    }
    if (distanceToNearestTSS <= upstream & 
            TSSLen - distanceToNearestTSS > downstream)
    {
        upstreamOffset = upstream - distanceToNearestTSS 
        seq = getSequence(id=as.character(LocationParameters[1]),
                          type="ensembl_gene_id",
                          seqType="gene_exon_intron",
                          upstream=upstreamOffset,
                          mart=mart)
        start = 1
        end = seqLen + 1
        seq1 = substr(seq[1], start, end)
    }
    else if (TSSLen - distanceToNearestTSS < downstream & 
                 distanceToNearestTSS > upstream)
    {
        downstreamOffset = downstream - TSSLen + distanceToNearestTSS
        seq = getSequence(id=as.character(LocationParameters[1]), 
                          type="ensembl_gene_id",
                          seqType="gene_exon_intron",
                          downstream=downstreamOffset,
                          mart=mart)
        start = distanceToNearestTSS - upstream
        end = distanceToNearestTSS + downstream + 1
        seq1 = substr(seq[1], start, end)
    }    
    else if ( distanceToNearestTSS > upstream & 
                  TSSLen - distanceToNearestTSS >= downstream)
    {
        seq = getSequence(id=as.character(LocationParameters[1]), 
                          type="ensembl_gene_id",
                          seqType="gene_exon_intron",
                          mart=mart)
        start = distanceToNearestTSS - upstream
        end = distanceToNearestTSS + downstream + 1
        seq1 = substr(seq[1], start, end)
    }
    else if (TSSLen - distanceToNearestTSS <= downstream & 
                 distanceToNearestTSS <= upstream)
    {
        downstreamOffset = downstream - TSSLen + distanceToNearestTSS
        upstreamOffset = upstream - distanceToNearestTSS
        seq1 = getSequence(id=as.character(LocationParameters[1]), 
                           type="ensembl_gene_id",
                           seqType="gene_exon_intron",
                           upstream=upstreamOffset,
                           mart=mart)
        seq2 = getSequence(id=as.character(LocationParameters[1]), 
                           type="ensembl_gene_id",
                           seqType="gene_exon_intron",
                           downstream=downstreamOffset,
                           mart=mart)
        seq3 = substr(seq1[1], 1, upstreamOffset)
        seq = paste(seq3, seq2[1], sep="")
        start = 1
        end = seqLen + 1
        seq1 = substr(seq, start, end)
    }
    
    if (is.na(seq1))
    {
        seq1 ="No Sequence Found"
    }
    temp = c(LocationParameters[1:4], seq1)
    dim(temp) =c(1,5)
    
    colnames(temp) = c("feature_id", "distancetoFeature", 
                       "upstream", "downstream", "seq")
    list(feature_id=temp[1],
         distancetoFeature=temp[2],
         upstream=temp[3],
         downstream=temp[4],
         seq=temp[5])
}
