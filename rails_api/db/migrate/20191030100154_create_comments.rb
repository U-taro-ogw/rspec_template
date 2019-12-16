class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :book, foreign_key: true, null: false
      t.string :text, null: false

      t.timestamps
    end
  end
end
