/// A grid with boxes, each row taking on the height of the highest box on that row.
/// Items need to be a dictionary with a *content* and *color* field.
#let box-grid(columns: none, inset: 0.5em, radius: 0.5em, column-gutter: 0.5em, row-gutter: 0.5em, ..items) = context {
  if columns == none { columns = items.len() }

  let rows = items.pos().chunks(columns)

  let inner-box(content, width: auto, height: auto, color: luma(100)) = box(
    inset: inset,
    radius: radius,
    fill: color,
    width: width,
    height: height,
    content,
  )

  grid(
    columns: columns * (1fr,),
    column-gutter: column-gutter,
    row-gutter: row-gutter,
    ..for row in rows {
      row.map(item => {
        let height = row.map(item => measure(inner-box(item.content)).height).fold(0pt, calc.max)
        inner-box(item.content, width: 100%, height: height, color: item.color)
      })
    }
  )
}

/// A basic SWOT diagram made with grid-box
#let swot(
  strengths,
  weaknesses,
  opportunities,
  threats,
  str_color: rgb("#5D688A"),
  weak_color: rgb("#FFF2EF"),
  oppor_color: rgb("#FFDBB6"),
  thr_color: rgb("#F7A5A5"),
) = {
  let str = (
    content: [*Strengths* #v(0.5em) #list(..strengths)],
    color: str_color,
  )
  let weak = (
    content: [#align(right, [*Weaknesses*]) #v(0.5em) #list(..weaknesses)],
    color: weak_color,
  )
  let oppor = (
    content: [*Opportunities* #v(0.5em) #list(..opportunities)],
    color: oppor_color,
  )
  let thr = (
    content: [#align(right, [*Threats*]) #v(0.5em) #list(..threats)],
    color: thr_color,
  )

  box-grid(columns: 2, str, weak, oppor, thr)
}
