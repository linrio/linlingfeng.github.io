
plot.error <- function(x, y, sd, len = 1, col = "black", horiz = FALSE)
		{ 
		len <- len * 0.05 
			if (!horiz) 
			{	 
				arrows(x0 = x, y0 = y, x1 = x, y1 = y - sd, col = col, angle = 90, length = len) 
				arrows(x0 = x, y0 = y, x1 = x, y1 = y + sd, col = col, angle = 90, length = len) 
			} 
			else 
			{ 
				arrows(x0 = y, y0 = x, x1 = y - sd, y1 = x, col = col, angle = 90, length = len) 
				arrows(x0 = y, y0 = x, x1 = y + sd, y1 = x, col = col, angle = 90, length = len) 
			} 
		}

sd <- dataxx * 0.1 for (i in 1:3) plot.error(x[i, ], dataxx[i, ], sd = sd[i, ])