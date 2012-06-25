class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.float :latitude
      t.float :longitude
      t.integer :accuracy

      t.integer :positionable_id
      t.string  :positionable_type

      t.timestamps
    end
  end
end
