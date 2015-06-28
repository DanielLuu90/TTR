class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :email
      t.boolean :valid

      t.timestamps
    end
  end
end
