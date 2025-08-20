# frozen_string_literal: true

class ViewComponentWithInlineTemplate < ViewComponent::Base
  erb_template <<~ERB
    <body>
      <header>
        <h1 id="title"><%= title %></h1>
      </header>

      <section>
        <%= text %>
      </section>
    </body>
  ERB

  attr_reader :title, :text

  def initialize(title:, text:)
    @title = title
    @text = text
  end
end
