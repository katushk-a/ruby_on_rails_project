class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps
    end
    add_index :authors, :email
  end
end
