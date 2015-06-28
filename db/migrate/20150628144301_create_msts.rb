class CreateMsts < ActiveRecord::Migration
  def change
    create_table :msts do |t|
      t.string :ten
      t.string :noicutru
      t.string :mst
      t.string :cmnd
      t.string :ngaycap
      t.string :noicap

      t.timestamps
    end
  end
end
