#include <Rcpp.h>
using namespace Rcpp;
//[[Rcpp::export]]

NumericVector iterative_change(NumericVector  df1,NumericVector  df2){
int N1 = df1.size();
NumericVector df3(N1);
df3[0]=df2[0];


csv2LeafletMap <- function(TRZNo = 3, year0 = 2013){
TRZ_data <- rcsv(csvFile)
return(year0)
}


for(int i=1;i<N1;++i)
{df3[i]=df2[i-1]+df1[i];}
return df3;
}
//[[Rcpp::export]]
NumericVector my_cumsum(NumericVector vec1){

int N1 = vec1.size();
NumericVector sum_vec(N1);
sum_vec[0]=vec1[0];

for(int i=1;i<=N1;i++)
{sum_vec[i]=sum_vec[i-1]+vec1[i];}

return sum_vec;
}

//[[Rcpp::export]]
NumericVector circle_area(NumericVector vec1){
return vec1*vec1*3.1415;
}

