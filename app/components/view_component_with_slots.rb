# frozen_string_literal: true

class ViewComponentWithSlots < ViewComponent::Base
  renders_one :header, ViewComponentHeaderSlot
  renders_one :section, ViewComponentSectionSlot
end
