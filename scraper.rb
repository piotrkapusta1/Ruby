require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
	url = "https://www.amazon.pl/gp/bestsellers/books/27252596031?ref_=Oct_d_obs_S&pd_rd_w=Eyerw&pf_rd_p=dee41908-19dc-4cee-9cc0-3a33906a393b&pf_rd_r=SQXTPMET4X3HMP7P9AWM&pd_rd_r=a8f4ab73-2d6e-4468-9277-b9d82c6217e6&pd_rd_wg=tIlAw"
	unparsed_page = HTTParty.get(url)
	parsed_page = Nokogiri::HTML(unparsed_page)
	books_listings = parsed_page.css('div.zg-grid-general-faceout')
	books_listings.each do |books|
		book = {
		name: books.css('div._p13n-zg-list-grid-desktop_truncationStyles_p13n-sc-css-line-clamp-1__1Fn1y').text,
		price: books.css('span.p13n-sc-price').text
		}
		puts book[:name] + " => " + book[:price]
	end
end

scraper
