// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!

#let project(
  title: "",
  abstract: [],
  author: (),
  coworker: (),
  performedAt: "",
  submittedAt: "",
  date: none,
  body,
) = {
  // Set the document's basic properties.
  set document(author: author.name, title: title)
  set page(
    footer: context [
      #let page_number = counter(page).get().first()
      #(if page_number == 1 { 
        none 
      }
      else {
        align(center, str(page_number - 1))
      })
    ]
  )
  set text(font: "New Computer Modern", lang: "en")
  set text(font: "fonts/NanumMyeongJo", lang: "en", size:0.8em)

  // Figure 
  show figure.where(
    kind: image
  ): it => {
    set align(center)
    [
      #it.body
      #it.caption
    ]
  }
  show figure.where(
    kind: table
  ): it => {
    set figure.caption(position: top)
    set align(center)
    [
      #it.caption
      #it.body
    ]
  }
  show figure.where(
    kind: raw
  ): it => {
    set align(left)
    [
      #block(
        width: 100%,
        fill: luma(240),
        inset: 1em,
        [
          #it.body
        ]
      )
      #it.caption
    ]
  }
  
  // Configure equation numbering and spacing.
  show math.equation: set text(weight: 400)
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure appearance of equation references
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      // Override equation references.
      link(
        it.element.label,
        numbering(
          it.element.numbering,
          ..counter(math.equation).at(it.element.location())
        )
      )
    } else {
      // Other references as usual.
      it
    }
  }


  block(
    width: 100%,
    height: 100%,
    [
      #v(2.5em)

      #align(left)[
        Logic Design Lab Report
      ]
      
      #v(10em)

      // Title row.
      #align(center)[
        #block(text(weight: 700, 2.5em, title))
        #v(1em, weak: true)
      ]

      #v(1fr)

      #pad(left:10%, right: 10%)[#text(size:0.9em)[#abstract]]
      
      #v(3em)

      // Author information.
      #align(right)[
        학부: #author.department

        학번: #author.id 

        이름: #author.name 

        공동실습자: #coworker.join(", ") 

        #if (performedAt != "") [
          실습날짜: #performedAt 
          
        ]
        제출날짜: #submittedAt
      ]

      #v(2.5em)
    ]
  )

  //Configure Captioning
  set figure.caption(separator: ". ")
  show figure.caption: it => {
    set text(size:0.9em)
    set par(hanging-indent: 0mm)
    it
  }
  // set figure(numbering: "1", supplement: [Fig.])

  //Configure headings
  set heading(numbering: "i")
  show heading: title => locate(loc => {
    let levels = counter(heading).at(loc)
    let deepest = if levels != () {
      levels.last()
    } else {
      1
    }

    v(2pt)
    
    if title.level == 1 [
      #linebreak()
      #set text(size:1em)
      #upper[
        #if (title.body==[Bibliography]) [
          #numbering("I. ", deepest+1)
          #title.body
        ] else [
          #numbering("I. ", deepest)
          #title.body
        ]
      ]
    ]

    if title.level == 2 [
      #set text(size:1em)
      #numbering("A. ", deepest)
      #title.body
    ]

    if title.level == 3 [
      #set text(size:1em, weight: "semibold")
      #numbering("1. ", deepest) 
      #title.body
    ]
    
    if title.level == 4 [
      #set align(left)
      #set text(size:0.9em, weight: "semibold")
      #set par(first-line-indent: 0pt)
      #numbering("a. ", deepest) 
      #title.body
    ]

    v(5pt)
  })
  
  // Main body.
  set par(justify: true, first-line-indent: 1.2em, leading: 0.7em)
  
  body
}