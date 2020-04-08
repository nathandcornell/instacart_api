# frozen_string_literal: true

require "cgi"
require_relative "../models/item"
require_relative "./common"

module InstacartApi
  module Search
    include Common

    def search(term:, store: default_store, department: nil)
      total_pages = total_pages(term: term, store: store, dept: department)

      (1..total_pages).map do |page|
        data = perform_search(
          term: term, store: store, page: page, dept: department
        )

        data.fetch("items").map { |item_json| Item.new(item_json) }
      end.flatten
    end

    private

    def perform_search(term:, store:, page: 1, dept: nil)
      term_query = CGI.escape term

      url = "v3/containers/#{store}/search_v3/#{term_query}?per=40&page=#{page}"
      url += "&dept_id=#{dept.id}" if dept

      response = get(url: url)

      data_json(response: response, key: "search_result_set_")
    end

    def total_pages(term:, store:, dept: nil)
      data_json = perform_search(term: term, store: store, dept: dept)
      data_json.dig("pagination", "total_pages")
    end
  end
end
