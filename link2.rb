# allows user to view all the links on a page, choose what link they want to click, and click on it
# keeps track of what page we are on

require 'mechanize'

# module to print all the links on a page, get the current page for use (module adds functionality to our class Browser)
module Show
	# gets the current page of the uri you are currently on
	def get_page
		agent.get(page.uri)
	end
	# prints the page links from the page you are currently on
	def print_page_links
		puts
		puts "These are the page links!"
		puts
		get_page.links.each do |link|
			p link.text.strip
			links_arr << link.text.strip
		end
	end
end

class Page
	attr_accessor :uri
	def initialize(uri)
		@uri = uri
	end
end

class Browser
	include Show
	attr_accessor :agent, :page, :links_arr
	def initialize(uri)
		@agent = Mechanize.new
		@page = Page.new(uri)
		@links_arr = []
	end
	
	def go
		print_page_links
	
		valid = true
		while valid == true
			puts
			puts "Which link would you like to click on? (type 'exit' to quit)"
			puts

			x = 0
			while x == 0
				user_input = gets.chomp
				if links_arr.include?(user_input)
					new_page = get_page.links.find { |l| l.text == user_input }.click
					puts "You are currently on the #{new_page.title} page"
					x = 1
				elsif user_input == 'exit'
					x = 1
					valid = false
				else
					puts "please enter a valid link to enter"
					x = 0
				end
			end
		end
		get_page = new_page
		puts "You ended on the #{get_page.title} page!"
	end
end

browser = Browser.new('http://www.classifiedsgiant.com/?affiliate_pro_tracking_id=2867:1:')
browser.go


