module ApplicationHelper

	#Returns full title depending on if page title exists
	def full_title(page_title = '')
		base_title = "Ruby on Rails Tutorial Sample App"
		if page_title.empty?
			base_title
		else
			page_title + ' | ' + base_title
		end
	end
	
end
