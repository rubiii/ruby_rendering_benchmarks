# frozen_string_literal: true

HTML_APP_ERUBI = <<~HTML
<body>
  <%= render_header(title: BM_KWARGS.fetch(:title)) %>
  <%= render_section(text: BM_KWARGS.fetch(:text)) %>
</body>
HTML

HTML_HEADER_ERUBI = <<~HTML
<header>
  <h1 id="title"><%= ERB::Escape.html_escape(title) %></h1>
</header>
HTML

HTML_SECTION_ERUBI = <<~HTML
<article>
  <%= ERB::Escape.html_escape(text) %>
</article>
HTML

class ErubiTemplate
  ERUBI_OPTS = {
    chain_appends: true,
    freeze_template_literals: false,
    bufval: "+''"
    # escape: true,
  }

  class_eval(c = <<~RUBY)
    # frozen_string_literal: true
    def render
      #{Erubi::Engine.new(HTML_APP_ERUBI, ERUBI_OPTS).src}
    end

    def render_header(title:)
      #{Erubi::Engine.new(HTML_HEADER_ERUBI, ERUBI_OPTS).src}
    end

    def render_section(text:)
      #{Erubi::Engine.new(HTML_SECTION_ERUBI, ERUBI_OPTS).src}
    end
  RUBY
end
