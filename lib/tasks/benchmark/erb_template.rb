# frozen_string_literal: true

HTML_APP_ERB = <<~HTML
<body>
  <%= render_header(title: BM_KWARGS.fetch(:title)) %>
  <%= render_section(text: BM_KWARGS.fetch(:text)) %>
</body>
HTML

HTML_HEADER_ERB = <<~HTML
<header>
  <h1 id="title"><%= ERB::Escape.html_escape(title) %></h1>
</header>
HTML

HTML_SECTION_ERB = <<~HTML
<article>
  <%= ERB::Escape.html_escape(text) %>
</article>
HTML

class ErbTemplate
  class_eval(c = <<~RUBY)
    # frozen_string_literal: true
    def render
      #{ERB.new(HTML_APP_ERB).src}
    end

    def render_header(title:)
      #{ERB.new(HTML_HEADER_ERB).src}
    end

    def render_section(text:)
      #{ERB.new(HTML_SECTION_ERB).src}
    end
  RUBY
end
