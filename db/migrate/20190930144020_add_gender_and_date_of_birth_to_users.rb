class AddGenderAndDateOfBirthToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :gender, :integer, default: 0
    add_column :users, :date_of_birth, :datetime
  end
end
