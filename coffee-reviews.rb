#!/usr/bin/env ruby
# DATA SCRAPER

require 'net/http'
# require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'pry'


@coffee_makers_doc = Nokogiri::HTML(open("http://www.amazon.com/Drip-Coffee-Machines-Makers/b?ie=UTF8&node=289745"))
@urls = @coffee_makers_doc.css("span.asinReviewsSummary a").map { |link| link['href'] }
#need to do loop through
url_one_page_ratings='http://www.amazon.com/Keurig-Elite-Brewing-System-Black/product-reviews/B00AQ9NIO0/ref=lp_289745_1_1_cm_cr_acr_txt?ie=UTF8&showViewpoints=1'

def get_noko_data(url)
  Nokogiri::HTML(open(url))
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

def delete_negative_reviews(hash)
  hash = hash.delete_if{|_,v| v == "1"}
  hash = hash.delete_if{|_,v| v == "2"}
  hash = hash.delete_if{|_,v| v == "3"}
end


@urls.each do |url|
  @doc = get_noko_data(url)
  @ratings = get_ratings(@doc)
  @reviews = get_reviews(@doc)
  @ratings_and_reviews = Hash[@reviews.zip(@ratings)]
  @ratings_and_reviews = delete_negative_reviews(@ratings_and_reviews)
  @reviews = []
  @ratings_and_reviews.each do |review, rating|
    @reviews << review
  end
  @reviews
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
