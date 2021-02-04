class Public::HomesController < ApplicationController
  def top
    @items=Item.limit(4).order(id: :desc)
  end

  def about
  end
end
