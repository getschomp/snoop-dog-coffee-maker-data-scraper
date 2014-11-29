#!/usr/bin/env ruby

# YOUR CODE HERE - GET SCRAPING
require 'net/http'
# require 'sinatra'
require 'nokogiri'


uri = URI('http://www.cnet.com/topics/coffee-makers/products/')
html = Net::HTTP.get(uri)
puts html
