P2App = ->(title:, text:) {
  html5 {
    body {
      render(P2Header, title:)
      render(P2Content, text:)
    }
  }
}

P2Header = ->(title:) {
  header {
    h2(title, id: "title")
    button "1"
    button "2"
  }
}

P2Content = ->(text:) {
  article {
    h3 text
    p "Hello, world!"
    div {
      a(href: "https://example.com") { h3 "foo bar" }
      p "lorem ipsum"
    }
  }
}
