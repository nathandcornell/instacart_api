# frozen_string_literal: true

require "ostruct"
require_relative "./item"

class CartItem < OpenStruct
  def item
    Item.new(data.fetch("item"))
  end

  def qty
    data.fetch("qty")
  end

  def qty_type
    data.fetch("qty_type")
  end

  def price
    data.dig("pricing", "price")
  end
end
