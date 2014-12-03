#!/usr/bin/env ruby
# DATA SCRAPER

require 'net/http'
# require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'pry'


@coffee_makers_doc = Nokogiri::HTML(open("http://www.amazon.com/Drip-Coffee-Machines-Makers/b?ie=UTF8&node=289745", {"User-Agent"=>"Mozilla"}))
@urls = @coffee_makers_doc.css("span.asinReviewsSummary a").map { |link| link['href'] }


#   @coffee_maker_doc = Nokogiri::HTML(open(url, {"User-Agent"=>"Mozilla"}))
#   @ratings_noko = @coffee_maker_doc.css('table#productReviews span.swSprite.s_star')
#   i=0
#   while i<= (@ratings_noko).length do
#     @ratings << (@coffee_maker_doc.css('table#productReviews span.swSprite')[i].text).chr
#     @reviews << @coffee_maker_doc.css("div.reviewText")[i].text
#     i+=1
#   end
#
#   @ratings_and_reviews = Hash[@ratings.zip(@reviews)]
# end

url_one_page_ratings='http://www.amazon.com/Keurig-Elite-Brewing-System-Black/product-reviews/B00AQ9NIO0/ref=lp_289745_1_1_cm_cr_acr_txt?ie=UTF8&showViewpoints=1'

def get_noko_data(url)
  Nokogiri::HTML(open(url, {"User-Agent"=>"Mozilla"}))
end

doc_one_page = get_noko_data(url_one_page_ratings)

def get_ratings(doc)
  ratings = []
  doc.css('table#productReviews span.swSprite:first-child').each do |rating|
    ratings << rating.text.chr
  end
  ratings.reject!.with_index{|_, i| i.odd?}
end

def get_reviews(doc)
  reviews = []
  doc.css("div.reviewText").each do |review|
    reviews << review.text
  end
  reviews
end

#for ratings go through each page and each time concatinate old array to new.
def get_next_page_url(first_page_doc)
  first_page_doc.css('span.paging:first-of-type a:last-of-type').first['href']
end

@urls.each do |url|
  @doc = get_noko_data(url)
  @ratings = get_ratings(@doc)
  @review = get_reviews(@doc)
  #@ratings_and_reviews = Hash[@ratings.zip(@reviews)]
  binding.pry
end
#go through each page and each time concatinate old array to new

#@ratings_and_reviews = Hash[(@ratings.zip(@reviews)]



# def  get_rating(doc)
#   doc.css('table#productReviews span.swSprite.s_star')
# end



#
# def countwords(string)
#
#   subedString = string.gsub(/([^A-Za-z0-9]+)/,' ').downcase
#   arrayofwords=subedString.split(' ')
#   countinghash=Hash.new
#
#
#   arrayofwords.each do |x|
#     if countinghash.key?(x)
#       countinghash[x] +=1
#     else
#       countinghash[x] = 1
#     end
#
#   end
#
#   twoDArray=countinghash.sort_by{|k,v| -v}
#   oneDarray=twoDArray.flatten
#
#   # i want to refactor the code so that its a while loop that simply goes through
#   #   puts the 2D array without flattening
#
#   i=0
#   oneDarray.each do |value|
#     if i.even? && i<ARGV.first.to_i*2
#       print "#{value}:"
#     elsif i.odd? && i<=ARGV.first.to_i*2#when command line called take the first value and multiply by 2
#       print "#{value}"
#       puts " "
#     else
#     end
#     i+=1
#   end
#
# end



# @coffee_maker_review_urls.each |reviews_url| do
#   puts reviews_url
# end

# @coffee_maker_review_pages.each do |review_url|
#   @reviews = @doc.css('table#productReviews ')
#   @stars = @doc.css('table#productReviews ')
# end
