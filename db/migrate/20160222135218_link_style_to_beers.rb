class LinkStyleToBeers < ActiveRecord::Migration
	def change
	  Beer.all.each do |b| b.style = (Style.find_by name:b['style_old'])
		  b.save
	  end
      	end
end
