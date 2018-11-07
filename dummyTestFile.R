library(ggplot2)

theme_old <- theme(panel.grid.minor = element_blank(),
                   panel.grid.major = element_blank(),
                   panel.background = element_blank(),
                   plot.background = element_rect(fill="#F9F0Ea"),
                   panel.border =  element_blank(),
                   axis.line = element_blank(),
                   axis.text.x = element_blank(),
                   axis.text.y = element_text(colour=NA),
                   # axis.text.y = element_blank(),
                   axis.ticks = element_blank(),
                   axis.title.x = element_blank(),
                   axis.title.y = element_blank(),
                   # I'm using xkcd fonts, replace or install if you don't have it.
                   text = element_text(size=14, family="xkcd"),
                   axis.line = element_line(colour = "black", linetype = "solid", size = 1),
                   axis.line.y = element_blank(),
                   plot.title = element_text(size=22))



# The floating dress 
a <- c(-3, -1.5, -0.9, -0.3, 0.6, 1, 1.5, 2, 3)
b <- c(0.004431848, 0.03, 0.0044, 0.03, 0.01, 0.030, 0.0044, 0.015, 0.004431848)

data <- data.frame(a = a, b = b)
c <- c(-0.40, 0.04)
d <- c(0.27, 0.27)
data2 <- data.frame(c = c, d = d)

# paranormal
gplot2 <- ggplot(data, aes(x=a, y=b)) + geom_line(size = 3)
gplot2 <- gplot2 + stat_function(fun = dnorm, size = 3) +
  geom_point(data = data2, aes(x=c, y=d), pch=0x30, size=6) +
  geom_point(data = data2, aes(x=c-0.008, y=d-0.006), pch=19, size=5) +
  labs(title = "Paranormal Distribution") + theme_bw()

