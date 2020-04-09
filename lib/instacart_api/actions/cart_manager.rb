# frozen_string_literal: true

require_relative "../models/cart"
require_relative "../models/cart_item"
require_relative "../models/store"
require_relative "./common"

module InstacartApi
  module CartManager
    include Common

    def current_cart(cart_id:)
      return @_current_cart if @_current_cart

      refresh_cart(cart_id: cart_id)
    end

    def refresh_cart(cart_id:)
      @_current_cart = fetch_cart(cart_id: cart_id)
    end

    private

    def fetch_cart(cart_id:)
      response = get(url: "v3/containers/carts/#{cart_id}")

      json_body = JSON.parse(response.body)

      Cart.new(json_data: json_body)
    end
  end
end
