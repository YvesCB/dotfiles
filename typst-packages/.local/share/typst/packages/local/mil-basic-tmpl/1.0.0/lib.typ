#let std-margin = 4em

#let conf(
  doc_title: "",
  classification: "INTERN",
  classification_attach: "INTERN",
  zugehoerigkeit: [Kompanie \ Zug],
  ort: "Ort",
  author: "Vorname Name",
  funktion: "CI",
  doc,
) = {
  set page(
    paper: "a4",
    margin: (top: 8em, bottom: 6em, left: std-margin + 5em),
    header: grid(
      columns: (1fr, 1fr),
      align: (left, left),
      box(inset: (x: -3.4em, y: 0em), image(
        "./swiss-banner.png",
        width: auto,
        height: 3em,
      )),
      text(size: 8pt, luma(100), [Eidgenössisches Department für Verteidigung \
        Bevölkerungsschutz und Sport VBS \ \
        *Schweizer Armee* \
        Kdo Cyber - Führungsunterstützungsbrigade 41]),
    ),
    header-ascent: 20%,
    footer: context {
      box(inset: (x: -std-margin))[
        #line(length: 100%)
        #grid(
          columns: (1fr, 1fr),
          align: (left, right),
          text(size: 8pt, doc_title), text(size: 8pt, counter(page).display("1/1", both: true)),
        )
      ]
    },
  )


  set text(
    font: "Liberation Sans",
    size: 11pt,
  )

  set heading(
    numbering: "1.1",
  )

  show heading: it => context {
    set text(size: 11pt)
    place(dx: -std-margin, counter(heading).display("1.1"))
    it.body
  }

  set enum(
    numbering: "1.a.",
    indent: 0em,
    body-indent: 0.6em,
  )

  set list(
    indent: 0em,
    body-indent: 1em,
    marker: ("-", "○"),
  )

  align(right, [*#classification* \ *Beilage(n) #classification_attach*])

  block(inset: (left: -std-margin), text(size: 13pt, weight: "bold", doc_title))

  doc

  block(zugehoerigkeit)

  block()[#author \ #funktion]
}
