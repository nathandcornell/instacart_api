# frozen_string_literal: true

require "ostruct"

class Department < OpenStruct
  def data
    label_action&.fetch("action")&.fetch("data")
  end

  def name
    data&.fetch("title")
  end

  def path
    data&.fetch("path")
  end

  def id
    tracking_params&.fetch("department_id")
  end

  def tracking_params
    data&.fetch("tracking_params")
  end
end
