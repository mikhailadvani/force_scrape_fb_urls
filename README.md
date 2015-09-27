# Force scrape Facebook URLs
In case Facebook has scraped your site in a state where meta tags were broken, the broken page might get cached in the Facebook memory and you would need to force scrape each URL. Simple ruby script to carry out the same in an automated way

##Steps

**bundle install**

**ruby fb_call.rb urls.csv 0 100** -- Will be refactoring this soon to make it cleaner

*urls.csv* - File name of all the URLs. One URL per line

*0* - Starting index

*100* - Batch size. This is used to throttle the requests to the Graph API

##Output

Output will be a CSV of the form

    NOT_SCRAPED,http://<URL1>
    SCRAPED,http://<URL2>
