class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word, null: false, unique: true
      t.integer :wordsize, null: false

      t.timestamps
    end
    
    add_index :words, [:word, :wordsize], unique: true
  end
end
