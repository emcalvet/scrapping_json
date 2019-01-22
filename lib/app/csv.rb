require 'pry'
require 'csv'
require_relative 'cityhall'
require 'nokogiri'
require 'open-uri'

def save_as_csv
    hash = Scrapper.new.get_townhall_urls
    File.open("./db/email.csv", "w") do |f|
        f << hash.map { |c| c.join(",")}.join("\n")
    end
    puts "bye"
end

save_as_csv
