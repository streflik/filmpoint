class AddEmbedCodeToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :embed_code, :text
  end

  def self.down
    remove_column :products, :embed_code
  end
end
