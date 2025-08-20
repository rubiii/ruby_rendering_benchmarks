# frozen_string_literal: true

P2Component = ->(title:, text:) {
  body {
    render(P2Header, title:)
    render(P2Section, text:)
  }
}

P2Header = ->(title:) {
  header {
    h1(title, id: "title")
  }
}

P2Section = ->(text:) {
  article text
}
