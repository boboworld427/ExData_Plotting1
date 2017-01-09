##############################################################################
#Plot3
##############################################################################
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="assignment1.zip")
unzip("assignment1.zip",files="household_power_consumption.txt")

data1<-read.table("household_power_consumption.txt",header = TRUE,sep = ";",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings="?")
data3<-data1
data3$DateTime<-paste(data3$Date,data3$Time)
data3$DateTime<-strptime(data3$DateTime, "%d/%m/%Y %H:%M:%S",tz="")
data3$Date<-NULL
data3$Time<-NULL
head(data3)
library(dplyr)
data3<-select(data3,DateTime,Global_active_power,Global_reactive_power,Voltage,Global_intensity,Sub_metering_1,Sub_metering_2,Sub_metering_3)
startdate<-strptime("01/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S",tz="")
enddate<-strptime("02/02/2007 23:59:59", "%d/%m/%Y %H:%M:%S",tz="")
data3<-subset(data3,data3$DateTime>=startdate&data3$DateTime<=enddate,drop=TRUE)
rownames(data3)<-NULL


png(filename = "plot3.png",width = 480, height = 480, units = "px")


plot(data3$DateTime,data3$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
par(new=T)
with(data3,plot(DateTime,Sub_metering_2,type="l",ann=F,axes=F,col="red",ylim=range(Sub_metering_1)))
par(new=T)
with(data3,plot(DateTime,Sub_metering_3,type="l",ann=F,axes=F,col="blue",ylim=range(Sub_metering_1)))
axis(2,c(0,10,20,30),lwd=1.6)
legend("topright",lty=1,col=c("black","red","blue"),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


dev.off()