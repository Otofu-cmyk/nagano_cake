class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :customer , foreign_key: true , :null => false
      t.string :shipping_postal_code , :null => false
      t.string :shipping_address , :null => false
      t.string :shipping_name , :null => false
      t.integer :ordered_status , :null => false , :default => 0
      t.integer :payment_method , :null => false
      t.integer :billing_amount , :null => false
      t.integer :shipping , :null => false
      t.timestamps
    end
  end
end
