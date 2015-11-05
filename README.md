# Force scrape Facebook URLs
In case Facebook has scraped your site in a state where meta tags were broken, the broken page might get cached in the Facebook memory and you would need to force scrape each URL. Simple ruby script to carry out the same in an automated way

##Steps

**ruby fb_call.rb urls.csv 0 100** -- Will be refactoring this soon to make it cleaner

*urls.csv* - File name of all the URLs. One URL per line

*0* - Starting index

*100* - Batch size. This is used to throttle the requests to the Graph API

##Setting up the access token
Login to Facebook with your personal ID

Go to https://developers.facebook.com/tools/explorer/

Generate a token

Set this token as an environment variable **ACCESS_TOKEN**

This token will expire every 1 hour. Reset the above token every time it expires. Continuation of the job from where it terminated in the previous run is possible using the start index in the script 

##Output

Output will be a CSV of the form

    NOT_SCRAPED,http://<URL1>
    SCRAPED,http://<URL2>
