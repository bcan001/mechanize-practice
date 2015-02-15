#http://thaiwood.io/movie-night-and-bacon-a-mechanize-tutorial-with-examples/

require 'mechanize'


Movie = Struct.new(:title, :year, :summary)

found_movies = []

afi_search_page = "http://www.afi.com/members/catalog/default.aspx"

agent = Mechanize.new

# gets the page and searches for a form with the name 'Search'. Types in the words 'Bacon' into the selected form
agent.get(afi_search_page) { |page|
	results = page.form_with(:name => 'Search') do |search|
		search.SearchText = 'Computer'
	end.submit

	# scans each link for :href that matches the desired Regex.
	# creates a new movie object for each of these links
	# updates the new movie object's year property with text that matches the regex
	# clicks on the link and saves that as the description_page of the new movie
	results.links_with(:href => /DetailView.aspx\?s=\&Movie=/).each do |link|
		current_movie = Movie.new
		current_movie.year = link.text.match(/\(\d{4}\)$/)[0].gsub(/\D/, "")
		description_page = link.click

		# get the movie title (goes into the description_page and gets the movie title)
		# Fortunately our movie title on this page is the only bold text that is also centered with html tags, allowing us to search with a simple XPath expression and parse each node:
		description_page.search("//center//b").each do |node|
			current_movie.title = node.text.strip;
		end

		# get movie summary if available
# 		While we're on the page we may as well also get the summary if its there. This XPath is going to be a bit more complicated and there are lots of ways to do it. In a nutshell, we're looking for a table data cell that has a table row that contains the text "Summary:" and then we want the 2nd node. With all that in mind here is an example of what we can use: //td//tr[contains(., 'Summary:')]/td[2]

# Since not all pages have Summaries, but may have the section, we'll double check that the resultant node, actually has any words in it, and if so, we'll store it:
		description_page.search("//td//tr[contains(., 'Summary:')]/td[2]").each do |node|
			if ((node.text =~ /\w/))
        current_movie.summary = node.text.strip
      end
    end
    # print out the information on the current_movie
    p "#{current_movie.year},#{current_movie.title},#{current_movie.summary}"
    puts
  end

  #//div[contains(@class,'product')]/p[not(@style)]/text()

}


