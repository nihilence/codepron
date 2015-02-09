class CreatePreviews < ActiveRecord::Migration
  def change
    create_table :previews do |t|
      t.string :title
      t.string :description
      t.text :html
      t.text :css
      t.text :js
      t.text :combined
      t.integer :author_id
      t.timestamps
    end

    add_index :previews, :author_id
  end
end
