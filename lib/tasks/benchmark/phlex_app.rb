class PhlexApp < Phlex::HTML
  def initialize(title:, text:)
    @title = title
    @text = text
  end

  def view_template
    doctype
    html {
      body {
        render PhlexHeader.new(title: @title)
        render PhlexContent.new(text: @text)
      }
    }
  end
end

class PhlexHeader < Phlex::HTML
  def initialize(title:)
    @title = title
  end

  def view_template
    header {
      h2(id: "title") { @title }
      button { "1" }
      button { "2" }
    }
  end
end

class PhlexContent < Phlex::HTML
  def initialize(text:)
    @text = text
  end

  def view_template
    article {
      h3 { @text }
      p { "Hello, world!" }
      div {
        a(href: "https://example.com") { h3 { "foo bar" } }
        p { "lorem ipsum " }
      }
    }
  end
end
