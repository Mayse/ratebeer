class RenameStyleInBeersToOld < ActiveRecord::Migration
  def change
	  change_table :beers do |t|
			  t.rename :style, :style_old
	  end
  end
end
