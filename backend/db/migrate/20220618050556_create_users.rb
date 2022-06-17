class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :email, unique: true
      t.text :username, unique: true
      t.text :password_digest

      t.boolean :admin, default: false
      t.boolean :trusted, default: false

      t.timestamps
    end

    add_index :users, :email
  end
end
