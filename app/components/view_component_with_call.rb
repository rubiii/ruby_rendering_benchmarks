# frozen_string_literal: true

class ViewComponentWithCall < ViewComponent::Base
  attr_reader :title, :text

  def initialize(title:, text:)
    @title = title
    @text = text
  end

  def call
    tag.header {
      tag.h1(title, id: "title")
    } +
    tag.section(text)
  end
end
