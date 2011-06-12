class CreateCodes < ActiveRecord::Migration
  def self.up
    create_table :codes do |t|
      t.integer :product_id
      t.integer :user_id
      t.string :value
      t.datetime :used_at


      t.timestamps
    end
    add_index :codes, :value, :unique => true


  end

  def self.down
    drop_table :codes
  end
end
