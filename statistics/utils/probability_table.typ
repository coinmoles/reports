// Independent function for a joint probability table
#let probability-table(variable, x_labels, data, digits: 5) = {
  let col_num = x_labels.len()

  // Start creating the table
  table(
    align: center + horizon,
    columns: col_num + 1, // Number of columns, accounting for row labels
    stroke: (x, y) => if x == 0 {
      (left: 1pt, right: 0.5pt)
    } + if y == 0 {
      (top: 1pt, bottom: 0.5pt)
    } + if x == col_num {
      (right: 1pt)
    } + if y == 1 {
      (bottom: 1pt)
    },
    [$ x $], ..for x_label in x_labels { ([#x_label],) },
    [$ P(#variable = x) $], ..for i in range(col_num) { ([
      #data.at(i, default: 0)
    ],) },

  )
}


// Independent function for a joint probability table
#let joint-probability-table(x_labels, y_labels, data, digits: 5) = {
  let col_num = x_labels.len()
  let row_num = y_labels.len()

  // Start creating the table
  table(
    align: center + horizon,
    columns: col_num + 2, // Number of columns, accounting for row labels
    stroke: (x, y) => if x == 0 {
      (right: 1pt)
    } + if y == 0 {
      (bottom: 1pt)
    } + if x == col_num + 1 {
      (left : 1pt)
    } + if y == row_num + 1 {
      (top: 1pt)
    },
    [], ..for x_label in x_labels { ([#x_label],) }, [Total],
    ..for i in range(row_num) {
      (
        [#y_labels.at(i, default: "")], 
        ..for j in range(col_num) { ([
          #calc.round(data.at(i, default: ()).at(j, default: 0), digits: digits)
        ],) }, 
        [#calc.round(data.at(i, default: ()).sum(default: 0), digits: digits)]
      ) // Data cells
    },
    [Total], ..for j in range(row_num) {([
      #calc.round(for i in range(col_num) {
        (data.at(i, default: ()).at(j, default: 0), )
      }.sum(), digits: digits)
    ],)}, [
      #calc.round(
        for i in range(col_num) { 
          for j in range(row_num) { (
            data.at(i, default: ()).at(j, default: 0),
          )}
        }.sum(), 
        digits: digits
      )
    ]
  )
}
