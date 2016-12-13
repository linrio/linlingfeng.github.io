library(kernlab)
library(caret)
x1 <- seq(0,pi,length.out=1000)
y1 <- sin(x1) + 0.1*rnorm(1000)
x2 <- seq(0,pi,length.out=1000)+2
y2 <- cos(x2) + 0.1*rnorm(1000)
data <- data.frame(c(x1,x2),c(y1,y2),c(rep(1,1000),rep(-1,1000)))
names(data) <- c('x1','x2','y')
vd = rbind(data.frame(x=x1,y=y1,t=as.factor(1)),data.frame(x=x2,y=y2,t=as.factor(2)))
ggplot(vd,aes(x=x,y=y))+geom_point(aes(color=t))

data$y <- factor(data$y)

model1 <- ksvm(y~.,data = data, kernel = 'vanilladot',C=0.01)
plot(model1,data = data,pch=10,)

model2 <- ksvm(y~.,data=data,kernel='vanilladot',C=1)
plot(model2,data=data)

model3 <- ksvm(y~.,data=data,kernel='rbfdot')
plot(model3,data=data)

fitControl <- trainControl(method = "repeatedcv", number = 10, repeats = 3,returnResamp = "all")
model <- train(Species~., data=iris,method='svmRadialCost',trControl = fitControl)