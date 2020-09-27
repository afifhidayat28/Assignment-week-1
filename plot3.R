tabel<- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
tabel$Date <- as.Date(tabel$Date, "%d/%m/%Y")
tabel <- subset(tabel,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
tabel <- tabel[complete.cases(tabel),]

#combine
dateTime <- paste(tabel$Date, tabel$Time)
dateTime <- setNames(dateTime, "DateTime")

#delete
tabel <- tabel[ ,!(names(tabel) %in% c("Date","Time"))]
#add to table
tabel <- cbind(dateTime, tabel)

#format
tabel$dateTime <- as.POSIXct(dateTime)

#3rd plot
with(tabel, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), cex=0.9, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#save plot3 to png
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()