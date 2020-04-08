# frozen_string_literal: true

module InstacartApi
  module Common
    def data_json(response:, key:)
      json_body = JSON.parse(response.body)

      json_body.dig("container", "modules").find do |mod|
        mod["id"] =~ /#{key}/
      end.fetch("data")
    end
  end
end
