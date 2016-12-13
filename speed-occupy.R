library(foreign)
A <- read.csv("g:/codes/R/speed-occupy.csv",header=TRUE)
#print(A)
result <- lm(A$speed~A$occupy+A$flow,data=A)
result
summary(result)
plot(A$occupy,A$speed)
A$logspeed <- log(A$speed)
result1 <- lm(logspeed~occupy+flow,data=A)
summary(result1)
output <- summary(result1)
SSR <- deviance(result1)
LL <-logLik(result1)
DegreesOfFreedom<-result1$df
Yhat<- result1$fitted.values
Resid<- result1$residuals
s<-output$sigma
CovMatrix <-s^2*output$cov
ANOVA<-anova(result1)
confidentinterval<-confint(result1)
effects(result1)
plot(result1)