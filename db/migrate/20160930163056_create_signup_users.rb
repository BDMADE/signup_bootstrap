class CreateSignupUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :signup_users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin

      t.timestamps
      t.index ['email'], name: 'index_users_on_email', unique: true
    end
  end
end
