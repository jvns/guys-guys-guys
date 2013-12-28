library("ggplot2")
library("reshape")

responses <- read.csv("guys-guys-guys-no-email.csv")
responses <- responses[, 1:9]

mresponses <- melt(responses,
	               id.vars = c("Timestamp", "Do.you.identify.as.a.woman."))

mresponses <- transform(mresponses,
	                    isfemale = factor(ifelse(Do.you.identify.as.a.woman. == "Yes", 1, 0)))
mresponses <- transform(mresponses,
	                    variable = gsub(".", " ", variable, fixed = TRUE))
mresponses <- transform(mresponses, neutral = ifelse(value == "gender neutral", 1, 0))

ggplot(mresponses,
	   aes(x = variable, y = neutral, group = isfemale, fill = isfemale)) +
  stat_summary(fun.data = "mean_cl_boot",
  	           geom = "bar",
  	           position = "dodge") +
  stat_summary(fun.data = "mean_cl_boot",
  	           geom = "errorbar",
  	           position = "dodge") +
  coord_flip()
ggsave("errorbars.pdf", width = 12, height = 7)
