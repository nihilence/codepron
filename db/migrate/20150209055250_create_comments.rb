class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.integer :author_id, null: false
      t.integer :preview_id, null: false
      t.timestamps
    end

    add_index :comments, :author_id
    add_index :comments, :preview_id
  end
end
