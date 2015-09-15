#This Script is to practice writing in R as directed in the Appendix B of Primer in Ecology with R
#To run a given script, use ctrl+r when in Windows, or command+r when using Mac
'?'(mean)
# ^this brings up the help article in a NEW browser TAB on Arithmetic Mean, which tells you what it does, gives examples and how-to for usage of the function
help(mean)
# ^this brings up the same article
help("mean", htmlhelp=FALSE)
#gives an error stating there is an unused argument
help("mean", htmlhelp=TRUE)
#produces same error message
help(mean)
#^brings up the html help page as before. so, not sure what the command with the FALSE argument does. Is it supposed to close the help page?
options(htmlhelp=FALSE)
#^this command did not produce any error message. Thinking that the point of this and other commands is to prevent the help article from popping up in future runs of the script, like a cancellation
help.search("mean")
#^brings up any topics containing "mean" in Help
apropos("mean")
#apropos generally seems to mean concerning something specific. this command looks like it got the console to list all function commands that involve "mean"
Rsitesearch("violin")
#returned error saying 'could not find the function Rsitesearch'
RSiteSearch("violin")
#worked - illustrates that CASE MATTERS
RSiteSearch("violin", restrict = c("functions"))
#restricts or filters results to show fuctions with the term 'violin'
help(RSiteSearch)
#self explanatory
#B.2 ASSIGNMENT
