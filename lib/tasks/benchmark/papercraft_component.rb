# frozen_string_literal: true

PapercraftComponent = Papercraft.html { |title:, text:|
  body {
    emit(PapercraftHeader, title:)
    emit(PapercraftSection, text:)
  }
}

PapercraftHeader = Papercraft.html { |title:|
  header {
    h1(title, id: "title")
  }
}

PapercraftSection = Papercraft.html { |text:|
  article { text }
}
