schedule <- harvest*0  # gets rownames and colnames right

schedule <- matrix(c(
    0, 0, 0, 0, 1, 0, 0, 0, 0,
    0, 1, 0, 0, 1, 0, 0, 0, 1,
    0, 0, 0, 0, 0, 0, 0, 1, 0,
    1, 0, 0, 0, 1, 0, 0, 0, 0,
    1, 0, 0, 0, 1, 0, 0, 1, 0,
    1, 0, 0, 0, 1, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 1, 0
),byrow=TRUE,ncol=9)

rownames(schedule) <-  rownames(params$harvest)
colnames(schedule) <- paste("b",1:9,sep="")

