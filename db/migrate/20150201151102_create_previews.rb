class CreatePreviews < ActiveRecord::Migration
  def change
    create_table :previews do |t|
      t.string :title
      t.string :html_input
      t.timestamps
    end
  end
end
