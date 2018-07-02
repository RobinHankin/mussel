schedule <- harvest*0  # gets rownames and colnames right

if(FALSE){
  schedule <- matrix(c(
    0, 0, 0, 0, 1, 0, 0, 0, 0,
    0, 1, 0, 0, 1, 0, 0, 0, 1,
    0, 0, 0, 0, 0, 0, 0, 1, 0,
    1, 0, 0, 0, 1, 0, 0, 0, 0,
    1, 0, 0, 0, 1, 0, 0, 1, 0,
    1, 0, 0, 0, 1, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 1, 0
),byrow=TRUE,ncol=9)





}
rownames(schedule) <-  rownames(harvest)
colnames(schedule) <-  colnames(harvest)

