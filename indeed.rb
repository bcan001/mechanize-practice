require 'mechanize'


Job = Struct.new(:company, :title, :description)

search_page = 'http://www.indeed.com/'

agent = Mechanize.new

agent.get(search_page) { |page|
	results = page.form_with(:name => 'jobsearch') do |search|
		search.q = 'Supply Chain Management'
		search.l = 'Chicago, IL'
	end.submit

	#pp agent
	# scan each link for the job title using regex
	results.links_with(:href => /Manager/).each do |link|

		new_job = Job.new
		new_job.title = link.text.match(/.*/)

		description_page = link.click
		new_job.company = description_page.title


		# get movie summary if available
		# description_page.search("//td//tr[contains(., 'Summary:')]/td[2]").each do |node|
		# 	if ((node.text =~ /\w/))
  #       current_movie.summary = node.text.strip
  #     end
  #   end

  	# description_page.each do |node|
  	# 	if ((node =~ /\w/))
  	# 		new_job.description = node.strip
  	# 	end
  	# end


		new_job.description = description_page.body.match(/Supply/)
		# need to iterate through each word and print out the description on the screen
		
   #  description_page.search("//td//tr[contains(., 'Summary:')]/td[2]").each do |node|
			# if ((node.text =~ /\w/))
   #      description_page.description = node.text.strip
   #    end
   #  end



		


		p "Company Name:#{new_job.company}, Job Title:#{new_job.title}, Job Description:#{new_job.description}"
	end


}