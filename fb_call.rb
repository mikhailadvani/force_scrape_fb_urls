require 'pry'
require 'rest-client'

urls = File.readlines(ARGV[0])

start_index = ARGV[1].to_i
length = ARGV[2].to_i
urls = urls[start_index..(start_index+length-1)]
urls.each do |url|
  graph_api_call_response = RestClient.get("http://graph.facebook.com/?id=#{url}")
  not_scraped = graph_api_call_response.include?("\"is_scraped\":false")
  RestClient.post("http://graph.facebook.com/?ids=#{url}&scrape=true","") if not_scraped
  status = not_scraped ? "NOT_SCRAPED" : "SCRAPED"
  puts "#{status},#{url}"
  sleep(0.5)
end


