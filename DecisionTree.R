########################################################################################################
# DecisionTree.R
########################################################################################################
# Creates a decision tree in R.
########################################################################################################

########################################################################################################
# Initial Set-Up
########################################################################################################
# Clear Variables
rm(list=ls(all=TRUE))

########################################################################################################
# CONSORT.R
########################################################################################################
# Create consort diagram for inclusion in manuscript

########################################################################################################
# Initial Set-up
########################################################################################################
# Clear Variables
rm(list=ls(all=TRUE))

# Load packages
test<-require(DiagrammeR)   #grViz()
if (test == FALSE) {
  install.packages("DiagrammeR")
  require(DiagrammeR)
}
test<-require(DiagrammeRsvg)   #()
if (test == FALSE) {
  install.packages("DiagrammeRsvg")
  require(DiagrammeRsvg)
}
test<-require(rsvg)   #()
if (test == FALSE) {
  install.packages("rsvg")
  require(rsvg)
}

rm(test)

########################################################################################################
# Pull & Display Consort
########################################################################################################
fig <- grViz(("digraph nodes { 
  size= '6,6'; 
  node [shape=box, margin = 0.2] ;
  0 [label='Include full-text review functions?'] ;
  0 -> 1 [labeldistance=2.5, labelangle=45, headlabel='No'];
  0 -> 2 [labeldistance=2.5, labelangle=-45, headlabel='Yes']
  1 [label='Be free?'] ;
  2 [label='Be free?'] ;
  node [shape=diamond, margin = 0.2] ;
  1 -> 3 [labeldistance=2.5, labelangle=45, headlabel='Yes'];
  1 -> 4 [labeldistance=2.5, labelangle=-45, headlabel='No'];
  2 -> 5 [labeldistance=2.5, labelangle=45, headlabel='Yes'];
  node [shape=box, margin = 0.2] ;
  2 -> 6 [labeldistance=2.5, labelangle=-45, headlabel='No'];
  node [shape=diamond, margin = 0.2] ;
  4 [label='Rayyan'] ;
  3 [label='Include deep learning?'] ;
  3 -> 9[labeldistance=2.5, labelangle=45, headlabel='Yes'];
  node [shape=box, margin = 0.2] ;
  3 -> 10 [labeldistance=2.5, labelangle=45, headlabel='No'];
  node [shape=box, margin = 0.2] ;
  9 [label='ASReview'] ;
  10 [label='Abstrackr'] ;
  5 [label='RevMan'] ;
  6 [label='Use machine-learning?'] ;
  6 -> 7 [labeldistance=2.5, labelangle=45, headlabel='Yes'];
  6 -> 8 [labeldistance=2.5, labelangle=-45, headlabel='No'];
  7 [label='EPPI-Reviewer, \nDistillerSR'] ;
  8 [label='Covidence'] ;
}"))

fig <- export_svg(fig)
fig <- charToRaw(fig)

rsvg_pdf(fig, "decisiontree.pdf")
# rsvg_png(fig, "decisiontree.png")   # low-res
rsvg_eps(fig, "decisiontree.eps")
