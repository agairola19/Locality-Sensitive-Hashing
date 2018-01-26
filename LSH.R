#CS422 Data Mining Homework - 4 II
#Akash Gairola

#Locality Sensitive Hashing

#Directly set the working directly using file pane 
#or use code setwd("D:/CS422 Data Mining/Homework-4")


library(textreuse)
files <- list.files("D:/MS/Sem 1/CS422 Data Mining/Homework - 4/corpus", full.names="T")


corpus <- TextReuseCorpus(files, tokenizer = tokenize_ngrams, n = 5,
                         keep_tokens = TRUE)

wordcount(corpus)
#(A) Total number of shingles in 100 documents is 22075
length(unlist(tokens(corpus)))

#(B)Dimensions of Characteristics matrix is 22075*100

#(C)
doc <- corpus[["orig_taske"]]
tokens(doc)[1:5] 

#(D) Percentage reduction is 98.1%
minhash <- minhash_generator(n=240, seed=100)

corpus <- TextReuseCorpus(files, tokenizer = tokenize_ngrams, n = 5,
                          minhash_func = minhash, keep_tokens = TRUE)


#(E) At 240 signatures (or hashes) we want a probability of 0.888  at
# a Jaccard similarity of 0.3 and above when we select b = 80, hence band = 80
lsh_probability(h = 240, b =  80, s = 0.3)


#(F)
# Run LSH and find candidate pairs
#We will get 26 candidate pairs
buckets <- lsh(corpus, bands = 80)
candidates <- lsh_candidates(buckets)
summary(candidates)

#(g) Sort the candidate pairs according to their score field
comp <- lsh_compare(candidates,corpus,jaccard_similarity)
comp<-comp[order(comp$score,decreasing=TRUE),]
head(comp,n=5)

#(h) If we use jaccard_similarity instead of LSH it would produce 4950 comparisons
# Ratio would be 4950/26 = 190.3846

#pairwise_compare(corpus,jaccard_similarity)



