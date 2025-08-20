HTML_APP_ERUBI = <<~HTML
<!DOCTYPE html>
<html>
  <body>
    <%= render_header(title: 'lorem ipsum') %>
    <%= render_content(text: 'lorem ipsum') %>
  </body>
</html>
HTML

HTML_HEADER_ERUBI = <<~HTML
<header>
  <h2 id="title"><%= ERB::Escape.html_escape(title) %></h2>
  <button>1</button>
  <button>2</button>
</header>
HTML

HTML_CONTENT_ERUBI = <<~HTML
<article>
  <h3><%= ERB::Escape.html_escape(text) %></h3>
  <p>Hello, world!</p>
  <div>
    <a href="<%= 'http://google.com/?a=1&b=2&c=3%204' %>">
      <h3>foo bar</h3>
    </a>
    <p>lorem ipsum</p>
  </div>
</article>
HTML

class ErubiApp
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

    def render_content(text:)
      #{Erubi::Engine.new(HTML_CONTENT_ERUBI, ERUBI_OPTS).src}
    end
  RUBY
end
