#Write a script to count the number of links in a web page

require 'mechanize'

mechanize = Mechanize.new

page = mechanize.get('http://stackoverflow.com/')

#pp page

# convert the title of the page into an array
# title = page.title
# title = title.split(//)
# p title

# prints out every link on the page
# page.links.each do |link|
#   puts link.text
# end


# finds the link 'log in' (found when running 'pp page') and clicks on it, then prints the title of the page
link = page.links.find { |l| l.text == 'log in' }.click
p link.title
link2 = page.links.find { |l| l.text == "Science Fiction & Fantasy" }.click
p link2.title


# submit a form
search_page = mechanize.get('http://chicago.craigslist.org/')
pp search_page
search_form = search_page.forms.first
##search_form = search_page.forms[1]
#search_form = search_page.form('name')
# or login_page.forms.first
# or login_page.form_with
# or login_form = login_page.form_with(action: '/sessions')
# => #<Mechanize::Form:0x007fa0eb4ee808>



# what you will type into the form
#search_form = "odd jobs"
# new_page = search_form.submit
# p new_page.title

puts
puts
puts
puts "This is the first form on the page"
p search_form

search_field = search_form.field_with(name: "query") 
search_field.value = 'white leather couch'

# submits the button:
new_page = search_form.submit
#p new_page.body
p new_page.title





