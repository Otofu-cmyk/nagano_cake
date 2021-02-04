class Item < ApplicationRecord
  has_many :cart_items
  has_many :customers, through: :cart_items
  has_many :orders, through: :ordered_products
  has_many :ordered_products
  belongs_to :genre

  attachment :image
end
