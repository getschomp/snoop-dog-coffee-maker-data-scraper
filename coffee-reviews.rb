#!/usr/bin/env ruby

# YOUR CODE HERE - GET SCRAPING
require 'net/http'
require 'sinatra'

source = Net::HTTP.get('http://www.amazon.com/b?ie=UTF8&node=6187232011', '/index.html')

puts source
