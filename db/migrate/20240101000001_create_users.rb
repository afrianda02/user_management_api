class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :encrypted_password, null: false, default: ""
      t.string :name, null: false
      t.integer :role, null: false, default: 0
      t.string :provider
      t.string :uid
      t.string :avatar_url
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, [:provider, :uid]
    add_index :users, :deleted_at
  end
end