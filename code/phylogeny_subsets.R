##script to produce marina phylogenies for Winitsky thesis
library(ape)
library(phytools)
library(treeio)
library(ggtree)
setwd("Documents/marina/")
##read in fully sampled ASTRAL topology
tree <- read.tree("data/RAxML_bipartitions.single_marina-4.tree")

## generate a topology containing one samplee for each taxon for which there is biogeochemical data available 
##read in excel file with infromation about tips to exclude
tip_data_biogeo <- read.csv(file = "data/bayestraits.csv")
tips_biogeo = c(tip_data_biogeo$TOREMOVEFROMPHYLOGENY.)
#drop tips
biogeo_tree <- drop.tip(tree,tip = tips_biogeo)
#output a tree file
write.tree(biogeo_tree, file = "output/Marina_biogeo.tree")

##to make the tree ultrametric for divergencetime estimation in Beast or revbayes
# enter secondary node calibration info 
calib <- makeChronosCalib(biogeo_tree, node = "root", age.min = 1,
                 age.max = 1, interactive = FALSE, soft.bounds = FALSE)
biogeo_timetree <- chronos(biogeo_tree, lambda = 1, model = "correlated", quiet = FALSE,
        calibration = calib,
        control = chronos.control())
write.tree(biogeo_timetree, file = "output/Marina_biogeo_timetree.tree")
##or plot it nicely with ggtree (check out: https://yulab-smu.top/treedata-book/chapter4.html)
ggplot(biogeo_tree, aes(x, y)) + geom_tree() + theme_tree() + geom_tiplab(size=3)


## make a fully sampled tree with a few weirdos excluded
##read in excel file with infromation about tips to exclude
tip_data_fullphylogeny <- read.csv(file = "data/fullphylogeny.csv")
tips_fullphylogeny = c(tip_data_fullphylogeny$TOREMOVEFROMPHYLOGENY.)
fullphylogeny <- drop.tip(tree,tip = tips_fullphylogeny)
write.tree(fullphylogeny, file = "output/Marina_fullphylogeny.tree")
ggplot(fullphylogeny, aes(x, y)) + geom_tree() + theme_tree()+ geom_tiplab(size=3)

##make a singles tree that looks good
##read in excel file with infromation about tips to exclude
tip_data_singles <- read.csv(file = "data/singles.csv")
tips_singles = c(tip_data_singles$Toremove.)
singles_tree <- drop.tip(tree,tip = tips_singles)
write.tree(singles_tree, file = "output/Marina_singles.tree")
ggplot(singles_tree, aes(x, y)) + geom_tree() + theme_tree() + geom_tiplab(size=3)
