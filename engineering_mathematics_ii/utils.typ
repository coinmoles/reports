#let expect = math.bold(math.upright([E]))
#let variance = math.bold(math.upright([Var]))
#let covariance = math.bold(math.upright([Cov]))
#let infintegral = $integral_(-infinity)^infinity$
#let gap = [#h(0.5em)]
#let center-align-block(content) = {
  block[
    #set align(center)
    #content
  ]
}