# frozen_string_literal: true

require "ostruct"

class Store < OpenStruct
  def id
    data.dig("retailer", "id")
  end

  def name
    data.dig("retailer", "name")
  end
end
