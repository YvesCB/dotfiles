#let juve-red = rgb("#98121a")

#let conf(
  title: none,
  subtitle: none,
  author: (),
  font: none,
  summary: none,
  opt_footer: none,
  doc
) = {
  set text(
    lang: "de",
    font: font,
    size: 10pt
  )
  set page(
    paper: "a4",
    header: box(inset: (x: -3.5em, y: -2em), image("./juve.svg", width: auto, height: 4em)),
    header-ascent: 50%,
    footer: [
      #set text(size: 8pt)
      *Stiftung Juventus Schulen* \ 
      Lagerstrasse 102 #text(juve-red)[|] Postfach #text(juve-red)[|] 8021 Zürich #text(juve-red)[|] 043 268 26 26 #text(juve-red)[|] #link("mailto:info@juventus.ch") #text(juve-red)[|] #link("www.juventus.ch")
    ]
  )
  set heading(
    numbering: "1.1",
  )
  set par(
    leading: 0.8em,
  )

  box(inset: (top: 14em, bottom: 1em), line(length: 100%, stroke: 2.5pt))
  par(spacing: 2em, leading: 1em, text(size: 32pt, weight: "bold", title))
  par(leading: 1em, text(size: 32pt, subtitle))

  box(width: 60%, inset: (top: 10em))[
    #summary \
    #v(3em)
    #datetime.today().display("[year].[month].[day]"), #author.name
  ]

  set enum(indent: 1em)
  set list(indent: 1em, marker: text(juve-red)[•])

  pagebreak()
  set page(
    header: box(inset: (x: -3.5em, y: -2em), image("./juve-logo-only.png", width: auto, height: 4em)),
    footer: context [#opt_footer #h(1fr) Seite #counter(page).display("1 von 1", both: true)],
  )

  set outline.entry(
    fill: none
  )

  show outline: outl => {
    line(length: 100%, stroke: 1pt)
    outl
  }

  outline()

  show heading: head => {
    if head.level == 1 {
      block(inset: (bottom: -0.6em), line(length: 100%, stroke: 1pt))
    }
    head
  }

  pagebreak()

  doc
}
