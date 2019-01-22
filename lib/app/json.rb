require 'json'
require 'nokogiri'
require 'open-uri'
require_relative 'cityhall'

def save_as_json
  hash = Scrapper.new.get_townhall_urls
  File.open("./db/emails.JSON","w") do |f|
    f << hash.to_json
  end
end

save_as_json