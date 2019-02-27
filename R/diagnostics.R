################################
# CLASS DIAGNOSTIC PLOT FUNCTION
################################

diagnostics<-function(resid,fitvalue,col="red")
{

par(mfrow=c(2,2))

# Plot 1 -Predicted vs observed
plot(y=resid,x=fitvalue, main='Fitted value plot',
	   ylab="Residual", xlab="Fitted value",col=col)
abline(h=0,col="blue")

# Plot 2 - Index Plot
index<-seq(1,length(resid))
plot(y=resid,x=index, main='Index plot', ylab="Residual", xlab="Index",col=col)
abline(h=0,col="blue")

# Plot 3 - A histogram with normal distribution for studentized residuals
hist(resid, freq=FALSE, main='Residuals distribution',
	   ylab='Frequency',xlab='Residual')
xfit<-seq(min(resid)*1.1,max(resid)*1.1,length=80)
yfit<-dnorm(xfit,mean=mean(resid),sd=sd(resid))
lines(xfit, yfit,col="blue",lwd=1) 

# Plot 4 - QQ-Plot
qqnorm(resid, main='Normal Q-Q plot', ylab='Ordered residual',xlab='Normal quantile',col=col)
qqline(resid,col='blue')

par(mfrow=c(1,1))
}


