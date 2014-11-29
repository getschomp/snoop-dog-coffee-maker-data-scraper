#!/usr/bin/env ruby

# YOUR CODE HERE - GET SCRAPING
require 'net/http'
# require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'pry'

@coffee_makers_doc = Nokogiri::HTML(open("http://www.amazon.com/Drip-Coffee-Machines-Makers/b?ie=UTF8&node=289745", {"User-Agent"=>"Mozilla"}))
@urls = @coffee_makers_doc.css("span.asinReviewsSummary a").map { |link| link['href'] }

@urls.each do |url|
  @coffee_maker_doc = Nokogiri::HTML(open(url, {"User-Agent"=>"Mozilla"}))
  @reviews = @coffee_maker_doc.css("div.reviewText").text + " "


  binding.pry


end



def countwords(string)

  subedString = string.gsub(/([^A-Za-z0-9]+)/,' ').downcase
  arrayofwords=subedString.split(' ')
  countinghash=Hash.new


  arrayofwords.each do |x|
    if countinghash.key?(x)
      countinghash[x] +=1
    else
      countinghash[x] = 1
    end

  end

  twoDArray=countinghash.sort_by{|k,v| -v}
  oneDarray=twoDArray.flatten

  # i want to refactor the code so that its a while loop that simply goes through
  #   puts the 2D array without flattening

  i=0
  oneDarray.each do |value|
    if i.even? && i<ARGV.first.to_i*2
      print "#{value}:"
    elsif i.odd? && i<=ARGV.first.to_i*2#when command line called take the first value and multiply by 2
      print "#{value}"
      puts " "
    else
    end
    i+=1
  end

end



# @coffee_maker_review_urls.each |reviews_url| do
#   puts reviews_url
# end

# @coffee_maker_review_pages.each do |review_url|
#   @reviews = @doc.css('table#productReviews ')
#   @stars = @doc.css('table#productReviews ')
# end
