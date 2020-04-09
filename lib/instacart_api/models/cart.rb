# frozen_string_literal: true

require_relative "./cart_item.rb"
require_relative "./store.rb"

class Cart
  def initialize(json_data:)
    @json_data = json_data
  end

  attr_reader :json_data

  def items
    return @_items if @_items

    store_ids = stores.map(&:id)
    @_items = {}

    store_ids.each do |store_id|
      item_modules = find_store_item_modules(store_id: store_id)

      @_items[store_id] = item_modules.map do |item_mod|
        CartItem.new(item_mod)
      end
    end
  end

  def stores
    return @_stores if @_stores

    headers = json_data.dig("container", "modules").select do |mod|
      mod["id"] =~ /cart_retailer_header/
    end

    @_stores = headers.map { |header| Store.new(header.dig("data", "action")) }
  end

  def totals
    return @_totals if @_totals

    store_ids = stores.map(&:id)
    @_totals = {}

    json_data.dig("container", "modules").find do |mod|
      mod["id"] =~ /cart_retailer_header_formatted/
    end.fetch("data")

    store_ids.each do |store_id|
      store_header = find_store_header(store_id: store_id)

      @_totals[store_id] = store_header.dig("data", "total")
    end
  end

  private

  def find_store_header(store_id:)
    json_data.dig("container", "modules").find do |mod|
      mod["id"] =~ /cart_retailer_header_formatted/ &&
        mod.dig("data", "retailer", "id") == store_id
    end
  end

  def find_store_item_modules(store_id:)
    json_data.dig("container", "modules").select do |mod|
      mod["id"] =~ /cart_item/ && mod.dig("data", "retailer_id") == store_id
    end
  end
end
