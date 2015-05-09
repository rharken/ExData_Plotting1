library(data.table)
library(lubridate)
pwr<-fread("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?", colClasses=rep("chr",9))

pwr<-pwr  %>% 
          filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
          mutate(Date=dmy(Date), 
                 Time=as.ITime(strptime(Time, "%H:%M:%S")),
                 DT=ymd_hms(paste(Date, Time)),
                 Global_active_power=as.numeric(Global_active_power),
                 Global_reactive_power=as.numeric(Global_reactive_power),
                 Voltage=as.numeric(Voltage),
                 Global_intensity=as.numeric(Global_intensity),
                 Sub_metering_1=as.numeric(Sub_metering_1),
                 Sub_metering_2=as.numeric(Sub_metering_2),
                 Sub_metering_3=as.numeric(Sub_metering_3))

png("plot3.png", width = 480, height = 480, units="px")
with(pwr, { plot(DT, Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
            lines(DT, Sub_metering_2, col="red")
            lines(DT, Sub_metering_3, col="blue")})
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=rep(1,3))
dev.off()