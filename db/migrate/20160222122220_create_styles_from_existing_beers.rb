class CreateStylesFromExistingBeers < ActiveRecord::Migration
      	def change
		Beer.all.each {|b| Style.create(name:b['style_old'])}
		styles = Style.select("MIN(id) as id").group(:name).collect(&:id)
		Style.where.not(id: styles).destroy_all
    	end
end

