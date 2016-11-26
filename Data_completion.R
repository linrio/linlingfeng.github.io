#source("E:/code/R/2016 regular analysis/new.R")
new <- read.csv("E:\\code\\R\\2016 regular analysis\\train.csv",header=T)
jun <- read.csv("E:\\code\\R\\2016 regular analysis\\introduction.csv",header = T)
row <- length(new[,1])
column <- length(new[1,])
row
column

average = jun[,4]
variable = jun[,1]

#data.frame中的NA值替换成0
new[is.na(new)] <- 0
new
class(new)

newo = data.frame(RA = 0,GENDER = 0,DRWITHGL = 0,NRWITHGL = 0,RAXISLEG = 0)
newo = newo[-1,]


#查找NA并补为平均数，删除无效样本，count是个计数器，用于计数样本中缺失变量的个数
i = 1
while(i <= row ){
	count = 0
	for (j in 1:column ){
		if (new[i,j]==0){
			new[i,j] = average[j]
			count = count +1
		}
	}

#无效样本的定义为缺失的个数大于总变量数的一半
	if (count> column/2){
		dele = i
		new=new[-i,]
		cat ("delete the row of ",dele,"\n")
		print (i)
		#i = i - 1
	}
	i = i + 1
}
print(new)

#重新写一遍train数据，删除了4条无效样本（无效样本的定义为缺失的个数大于总变量数的一半）
for (i in 1:length(new[,1]) ){
	for (j in 1:length(new[1,]) ){
		newo[i,j] = new[i,j]
	}
}
print (newo)

#新的train数据写入csv格式
write.csv(newo,file = "E:\\code\\R\\2016 regular analysis\\trainNew.csv")
write.csv(variable,file = "E:\\code\\R\\2016 regular analysis\\variable.csv")

