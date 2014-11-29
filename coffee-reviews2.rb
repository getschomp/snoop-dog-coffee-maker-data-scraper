#!/usr/bin/env ruby

# YOUR CODE HERE - GET SCRAPING
require 'net/http'
# require 'sinatra'
require 'nokogiri'
require 'pry'

#the long way below
uri = URI('http://www.amazon.com/')
@amazon_html = Net::HTTP.get(uri)
puts @amazon_html
request = Net::HTTP::Get.new(uri.request_uri)
request.initialize_http_header({"User-Agent" => "Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20100101 Firefox/21.0"})
@nokogiri_html = Nokogiri::HTML(@amazon_html)

@nav_logo = @nokogiri_html.css('span.nav-logo-base '
# @reviews=@nokogiri_html.css('table#productReviews div span')
# @links = @nokogiri_html.xpath('//a')

puts @links
puts @reviews
