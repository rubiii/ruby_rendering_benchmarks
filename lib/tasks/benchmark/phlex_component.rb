# frozen_string_literal: true

class PhlexComponent < Phlex::HTML
  attr_reader :title, :text

  def initialize(title:, text:)
    @title = title
    @text = text
  end

  def view_template
    body {
      render PhlexHeader.new(title:)
      render PhlexSection.new(text:)
    }
  end
end

class PhlexHeader < Phlex::HTML
  attr_reader :title

  def initialize(title:)
    @title = title
  end

  def view_template
    header {
      h1(id: "title") { title }
    }
  end
end

class PhlexSection < Phlex::HTML
  attr_reader :text

  def initialize(text:)
    @text = text
  end

  def view_template
    article { text }
  end
end
