require 'json'
access_token = ENV["ACCESS_TOKEN"]

def oauth_expired?(response)
  json_response = JSON.parse(response)
  if (!json_response["error"].nil?) && (json_response["error"]["code"].eql?(190))
    beep
    puts "Token Expired"
    return true
  end
  false
end

def beep
  for a in 1..10
    print "\a"
    sleep(0.1)
  end
end

urls = File.readlines(ARGV[0])

start_index = ARGV[1].to_i
length = ARGV[2].to_i
urls = urls[start_index..(start_index+length-1)]
counter = start_index
urls.each do |url|
  begin
    url.strip!
    graph_api_call_response = JSON.parse(`curl -s http://graph.facebook.com/?id=#{url}&access_token=#{access_token}`).to_h
    puts graph_api_call_response
    not_scraped = graph_api_call_response[:is_scraped]
    if not_scraped.nil?
      status = "nil"
    else
      if not_scraped
        status = "SCRAPED"
      else
        status = "NOT_SCRAPED"
      end
    end
    puts "#{counter},#{status},#{url}"
    response = `curl -s -X POST "https://graph.facebook.com/?ids=#{url}&scrape=true&access_token=#{access_token}"`
    puts response
    exit(1) if oauth_expired? response
    sleep(1)
  rescue Exception => e
    puts e.message
    puts "There was a failure for url: #{url}"
    beep
  end
  counter+=1
end
beep
