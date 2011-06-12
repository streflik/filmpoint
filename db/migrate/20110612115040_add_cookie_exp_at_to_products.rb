class AddCookieExpAtToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :cookie_exp_at, :datetime
  end

  def self.down
    remove_column :products, :cookie_exp_at
  end
end
