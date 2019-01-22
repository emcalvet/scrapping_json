require 'json'
require 'nokogiri'
require 'open-uri'
require_relative '/Users/emma/fichiers/THP/w3/d2/projet_csv/lib/app/cityhall'

def save_as_json
  hash = Scrapper.new.get_townhall_urls
  File.open("/Users/emma/fichiers/THP/w3/d2/projet_csv/db/emails.JSON","w") do |f|
    f << hash.to_json
  end
end

save_as_json