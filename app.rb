#Permet d'éviter d'appeler les gems dans chaque fichier
require 'bundler'
Bundler.require

#Permet d'utiliser les classes des fichiers dans app.rb
$:.unshift File.expand_path("./../lib", __FILE__)
require 'app/scrapper'

Scrapper.new.perform