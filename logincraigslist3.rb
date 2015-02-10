# logs a user into craigslist, then logs them out of craigslist

require 'mechanize'

agent = Mechanize.new
current_page = 'http://chicago.craigslist.org/'


# login to craigslist
agent.get(current_page) do |page|
	new_page = page.links.find { |l| l.text == 'my account' }.click
	p new_page.title

	# we are now located on the login page
	pp new_page

	# Submit the login form
  login_form = new_page.form("login")
  login_form['inputEmailHandle'] = "bcaneba@gmail.com"
  login_form['inputPassword'] = "theanswer"
  final_page = login_form.submit
  p final_page.title

  if final_page.title != new_page.title
  	puts "You are now logged in!"
  end

  # logout of craigslist
  final_page = final_page.uri.to_s
  pp final_page

  agent.get(final_page) do |page|
  	new_page = page.links.find { |l| l.text == 'log out' }.click
		pp new_page
		if new_page.title != page.title
			puts "You are looged out!"
		end
  end

end





