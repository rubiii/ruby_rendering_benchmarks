# frozen_string_literal: true

require_relative "view_component_app_header"
require_relative "view_component_app_stage"

class ViewComponentApp < ViewComponent::Base
  renders_one :header, ViewComponentAppHeader
  renders_one :stage, ViewComponentAppStage
end
