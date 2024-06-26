

##script to plot a cophyloplot
library(ape)
library(phytools)
library(treeio)
library(ggtree)
setwd("~/Desktop/marina/")

##import trees
tangle_raxml <- read.nexus(file = "data/marina_tangle_raxml.tree")
tangle_astral <- read.nexus(file = "data/astral_tangle.tree")

#import association files and make associations
associationfile <- read.csv(file = "data/association.csv")
association<- cbind(associationfile$V1, associationfile$V2)
association <- cbind(tangle_astral$tip.label,tangle_astral$tip.label)

pdf("cophylo.pdf", height = 40, width = 15)
##make cophylo object and plot
coplotA <- cophylo(tangle_raxml, tangle_astral, assoc = association)
plot(coplotA,link.type="curved",link.lwd=4, link.lty="solid",link.col=make.transparent("red", 0.25))
dev.off()
