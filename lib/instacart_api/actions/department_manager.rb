# frozen_string_literal: true

require_relative "../models/department"
require_relative "./common"

module InstacartApi
  module DepartmentManager
    include Common

    def departments(store: default_store)
      @_departments ||= {}

      @_departments[store] ||= fetch_departments(store: store)
    end

    def find_department(name:, store: default_store)
      departments(store: store).select do |dept|
        dept.name.downcase.eql? name.downcase
      end.first
    end

    private

    def fetch_departments(store:)
      response = get(
        url: "v3/containers/#{store}/browse_departments"
      )

      data = data_json(
        response: response, key: "browse_departments_container_departments_"
      )

      data.fetch("departments").map do |department_json|
        Department.new(department_json)
      end
    end
  end
end
