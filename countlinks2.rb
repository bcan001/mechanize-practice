#Write a script to count the number of links in a web page


require 'mechanize'

agent = Mechanize.new

puts "what page would you like to count the links?"
#input = gets.chomp
#input = 'http://stackoverflow.com/'
input = 'http://newyork.craigslist.org/'

agent.get(input) do |page|
	#pp page
	count = 0
	page.links.each do |link|
		p link.text.strip
		count += 1
	end

	puts
	puts "There are #{count} links on this web page!"
end