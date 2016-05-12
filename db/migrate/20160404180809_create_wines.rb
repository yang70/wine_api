class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string :name
      t.string :varietal
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
