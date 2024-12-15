#let with_cap(content, all_cap_alt: none, default_cap: none) = {
  (cap: default_cap) => {
    if (cap == none) {
      content
    }
    else if (cap == "*") {
      if (all_cap_alt != none) { 
        all_cap_alt
      }
      else {
        content.replace(regex("(^\w| \w|-\w)"), m=>upper(m.text))
      }
    }
    else if (cap == "1") {
      content.replace(regex("^\w"), m=>upper(m.text))
    }
    else {
      panic("Not a valid cap option")
    }
  }
}

#let subfigures(
  figures: (),
  numbering_rule: "a. ",
  columns: 1,
  label: none
) = {
  set text(size:0.8em)
  grid(
    columns: columns,
    stroke:none,
    row-gutter: 1em,
    column-gutter: 1em,
    ..range(columns).map(_ => 
      rect(width:100%, height:0%, stroke:none)
    ),
    ..figures
      .enumerate()
      .map(((num, (image, caption))) =>
        figure(
          image,
          numbering: none,
          caption: [#numbering(numbering_rule, num + 1)#caption]
        ),
      )
  )
}

#let space = h(0.5em)