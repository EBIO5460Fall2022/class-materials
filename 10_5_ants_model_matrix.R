# Model matrix

# The model matrix and the subset of the data used to demonstrate the model
# matrix (see lecture slides). The subset of points are indicated on the plot
# with blue rings.

# Data
ant <- read.csv("data/ants.csv")
ant$habitat <- factor(ant$habitat)

# Plot
plot(ant$latitude, ant$richness, col=ant$habitat, pch=20)

# Model
fitHxL <- glm(richness ~ habitat + latitude + habitat:latitude, family=poisson, data=ant)

# Data subset for demonstration used in class
antsub <- c(2,11,15,21,28,34,38,44)
antdemo <- ant[antsub,c(2,3,5)] #The subset used for the 
points(antdemo$latitude,antdemo$richness,col="blue",cex=1.5)
antdemo

# Model matrix
mm <- model.matrix(fitHxL)
mm
mm[antsub,] #The subset for antdemo
