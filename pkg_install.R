#Automatically install all the dependencies

#Make sure you enter the correct package name Function will not install not exsiting pkgs and cause inf loop


require(gtools)

install_pkg<-function(pkg_name,n=20)
{
#-----------helper functions------------
myTryCatch <- function(expr) {
  warn <- err <- NULL
  value <- withCallingHandlers(
    tryCatch(expr, error=function(e) {
      err <<- e
      NULL
    }), warning=function(w) {
      warn <<- w
      invokeRestart("muffleWarning")
    })
  list(value=value, warning=warn, error=err)
}

lib_func<-function(x)
{
library(x,character.only=T)
}
#-----------------------------------------
i=1
repeat{tryCatch({lib_func(pkg_name)},error=function(e) {})
  if(is.null(myTryCatch(lib_func(pkg_name))$error))
{
  break
}
 
b<-myTryCatch(lib_func(pkg_name))$error$message
c<-gregexpr("(?<=d \x91)[^\\x92]+",b,perl=T)
pos<-unlist(c)
l<-attr(c[[1]],which="match.length")
pkg.new<-substr(b,pos,pos+l-1)
install.packages(pkg.new)
i=i+1
if(i>n) stop("check pkg exist?")
}
}
