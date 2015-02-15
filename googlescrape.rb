# Uses mechanize to enter links and print out information on each page

require 'mechanize'


Page = Struct.new(:title, :description)

search_page = 'http://www.google.com/'

agent = Mechanize.new


agent.get(search_page) { |page|
	#pp page
	results = page.form_with(:name => 'f') do |search|
		search['q'] = 'dogs'
	end.submit

	# we are now on a page about fishes
	#pp agent

	results.links_with(href: /(url?)/ && /(&sa=U&ei)/ ).each do |link|
		p link
		new_page = Page.new
		new_page.title = link.text
		p new_page.title

		description_page = link.click

		#new_page.description = description_page.body

		description_page.search("//p").each do |node|
			if ((node.text =~ /\w/))
        new_page.description = node.text.strip
      end
    end

		p new_page.description
		puts "end of description *****************"
	end


}