# frozen_string_literal: true

require_relative "lib/instacart_api/client.rb"

client = Client.new(
  email: ENV.fetch("INSTA_EMAIL"),
  password: ENV.fetch("INSTA_PASSWORD"),
  default_store: "fairway-market"
)

bananas = client.search(term: "banana")

client.cart_id
# client.add_item_to_cart(item: "test", quantity: 1)