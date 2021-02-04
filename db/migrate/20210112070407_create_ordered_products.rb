class CreateOrderedProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :ordered_products do |t|
      t.references :order , :null => false
      t.references :item , :null => false
      t.integer :price , :null => false
      t.integer :quantity , :null => false
      t.integer :making_status , :null => false , :default => 0
      t.timestamps
    end
  end
end
