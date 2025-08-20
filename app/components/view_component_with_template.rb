# frozen_string_literal: true

class ViewComponentWithTemplate < ViewComponent::Base
  attr_reader :title, :text

  def initialize(title:, text:)
    @title = title
    @text = text
  end
end
