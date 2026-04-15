class CreateUserProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profiles do |t|
      t.references :user, foreign_key: true, null: false
      t.string :self_introduction, null: false

      t.timestamps
    end
  end
end
