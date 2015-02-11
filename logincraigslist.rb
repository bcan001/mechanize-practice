# logs a user into craigslist

require 'mechanize'

class Agent
	attr_accessor :agent, :current_page
	def initialize
		@agent = Mechanize.new
		@current_page = 'http://chicago.craigslist.org/'
	end
	def login(email,password)
		agent.get(current_page) do |page|
			new_page = page.links.find { |l| l.text == 'my account' }.click
			p new_page.title

			# we are now located on the login page
			pp new_page

			# Submit the login form
		  login_form = new_page.form("login")
		  login_form['inputEmailHandle'] = email
		  login_form['inputPassword'] = password
		  final_page = login_form.submit
		  p final_page.title

		  if final_page.title != new_page.title
		  	puts "You are now logged in!"
		  end
		end
	end
	def uri(page)
		page.uri.to_s
	end
	def logout
		# find the logout link on the current page and click it

	end
end

mech = Agent.new
mech.login("bcaneba@gmail.com","")

# current_page.uri.to_s => www.google.com


mech.logout