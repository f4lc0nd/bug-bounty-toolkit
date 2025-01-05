# Subdomain Enumerationsubfinder -d domain -all | tee -a domain.subs
subdominator -d domain  | tee -a domain.subs

# Check live subdomains
cat domain.subs | httpx -o domain.live
cat domain.live | wayback |anew xss-wayback
katana -list domain.live -o xss-katana
cat domain.live | gau --subs -o xss-gau

# Merge All results
cat xss-wayback xss-katana xss-gau |anew xss.txt

cat domain.live | wayback |anew xss-wayback
katana -list domain.live -o xss-katana
cat domain.live | gau --subs -o xss-gau

# Merge All results
cat xss-wayback xss-katana xss-gau | anew xss.txt

cat xss.txt |sort -u | grep "=" | egrep -iv ".(css|woff|woff2|txt|js|m4r|m4p|m4b|ipa|asa|pkg|crash|asf|asx|wax|wmv|wmx|avi|bmp|class|divx|doc|docx|exe|gif|gz|gzip|ico|jpg|jpeg|jpe|webp|json|mdb|mid|midi|mov|qt|mp3|m4a|mp4|m4v|mpeg|mpg|mpe|webm|mpp|_otf|odb|odc|odf|odg|odp|ods|odt|ogg|pdf|png|pot|pps|ppt|pptx|ra|ram|svg|svgz|swf|tar|tif|tiff|_ttf|wav|wma|wri|xla|xls|xlsx|xlt|xlw|zip)" | uro | httpx | anew xss

#Run knoxnl With GET & POST Methods
knoxnl -i xss.txt -X BOTH -s -o xssoutput.txt