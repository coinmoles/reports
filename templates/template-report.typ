#let template-report(
  title: [],
  student_id: [],
  author: [],
  body,
) = {
  set text(font: "New Computer Modern", lang: "en", size: 1em)

  show math.equation: eq => {
    if eq.block {
      align(left, eq)
    } else {
      eq
    }
  }

  //Configure list
  set list(marker: [•])
  set list(indent: 1em)

  // Paragraph
  set par(first-line-indent: 1em, justify: true)
  set text(size: 1em)

  // Document
  set document(title: title, author: author)

  align(top + left)[#student_id #author]
  align(center)[= #title]
  v(1em)
  body
}