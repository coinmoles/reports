#let template-assignment(
  title: [],
  student_id: [],
  author: [],
  body,
) = {
  set text(font: "New Computer Modern", lang: "en")

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
  set text(size: 0.8em)

  // Document
  set document(title: title, author: author)

  align(top + left)[#student_id #author]
  align(center)[= #title]

  body
}