# allows user to view all the links on a page, choose what link they want to click, and click on it
# keeps track of what page we are on

require 'mechanize'

agent = Mechanize.new
start_page = 'http://www.classifiedsgiant.com/?affiliate_pro_tracking_id=2867:1:'

def find_uri(page)
	#final_page = final_page.uri.to_s
	page.uri.to_s
end

new_page = agent.get(start_page)
pp new_page

#p find_uri(new_page)

links_arr = []
new_page.links.each do |link|
	p link.text.strip
	links_arr << link.text.strip
end
puts
puts "Which link would you like to click on?"
puts

x = 0
while x == 0
	#p new_page.title
	user_input = gets.chomp
	#user_input = "Monkeys"
	if links_arr.include?(user_input)
		new_page_2 = new_page.links.find { |l| l.text == user_input }.click
		puts "You are currently on the #{new_page_2.title} page"
		x = 1
	else
		puts "please enter a valid link to enter"
		x = 0
	end
end