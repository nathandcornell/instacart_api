# frozen_string_literal: true

require "ostruct"

class Item < OpenStruct
  def price
    pricing["price"].delete("$").to_f
  end

  def available?
    attributes.include?("available")
  end

  def buy_again?
    attributes.include?("previously_purchased")
  end

  def <=>(other)
    price <=> other.price
  end
end
