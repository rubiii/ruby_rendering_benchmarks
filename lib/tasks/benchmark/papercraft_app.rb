PapercraftApp = Papercraft.html { |title:, text:|
  html5 {
    body {
      emit(PapercraftHeader, title:)
      emit(PapercraftContent, text:)
    }
  }
}

PapercraftHeader = Papercraft.html { |title:|
  header {
    h2(title, id: "title")
    button "1"
    button "2"
  }
}

PapercraftContent = Papercraft.html { |text:|
  article {
    h3 text
    p "Hello, world!"
    div {
      a(href: "https://example.com") { h3 "foo bar" }
      p "lorem ipsum"
    }
  }
}
