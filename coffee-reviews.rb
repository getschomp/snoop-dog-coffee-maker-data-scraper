#!/usr/bin/env ruby

# YOUR CODE HERE - GET SCRAPING
require 'nokogiri'
require 'pry'

doc = Nokogiri::HTML(open('www.google.com'))
