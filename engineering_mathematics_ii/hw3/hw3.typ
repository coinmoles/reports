#import "../../templates/template-assignment.typ": *
#import "../utils.typ": *

#show: template-assignment.with(
  title: "Assignment 3",
  student_id: "2023-12675",
  author: "박지호",
)

== 3.3

- Let $X_i$ be the result of the $i$-th roll.

  - All $X_i$ are mutually independent, as the result of the dice roll do not affect one another.

  - $ expect[X_i] = sum_(k = 1)^6 k times 1 / 6 = 7 / 2 $

  - $ variance[X_i] = sum_(k = 1)^6 (k - expect[X_i])^2 times 1 / 6 = 35 / 12 $

- $ X = sum_(i = 1)^100 X_i $

  - $ expect[X] = sum_(i = 1)^100 expect[X_i] = 350 $

  - $ variance[X] = sum_(i = 1)^100 variance[X_i] = 875 / 3 $

- $ Pr(|X - 350| >= 50) <= (variance[X]) / 50^2 = 7 / 60 &"(Chevyshev's inequality)" $

== 3.6

- Let $X$ be the number of flips until the k-th head appears

- Let $X_i$ be the number of flips after the $(i - 1)$-th head until the $i$-th head appears (Excluding the $(i - 1)$-th flips and including the $i$-th flip)

  - All $X_i$ are mutually independent, as the number of flips until one head does not affect the number of flip until another head.

  - $ variance[X_i] = (1 - p) / p^2 $

- $ X = sum_(i=1)^k X_i $

  - $ variance[X] = sum_(i = 1)^k variance[X_i] = (k(1 - p)) / p^2 $

- $ variance[X] = (k (1 - p)) / p^2 $

== 3.7

- Let $X_d$ be the price after $d$ days

=== The expected value of $X_d$

- $
    expect[X_d] = p times r expect[X_(d - 1)] + (1 - p) times 1 / r expect[X_(d - 1)] = (p r^2 + 1 - p) / r expect[X_(d - 1)]
  $

- $ expect[X_0] = 1 $

- $ expect [X_d] = ((p r^2 + 1 - p) / r)^d $

=== The variance of $X_d$

- $
    expect[X_d #h(0em) ^2] = p times r^2 expect[X_(d - 1) #h(0em) ^2] + (1 - p) times (1 / r)^2 expect[X_(d - 1) #h(0em) ^2] = (p r^4 + 1 - p) / r^2 expect[X_(d - 1) #h(0em) ^2]
  $

- $ expect[X_0 #h(0em) ^2] = 1 $

- $ expect[X_d #h(0em) ^2] = ((p r^4 + 1 - p) / r^2)^d $

- $variance[X_d] = expect[X_d #h(0em) ^2]- (expect[X_d])^2
    = ((p r^4 + 1 - p)^d - (p r^2 + 1 - p)^(2d)) / r^(2d)$

== 3.15

- Proposition: for two random variables $X$ and $Y$, if $expect[X Y] = expect[X] expect[Y]$, then $variance[X + Y] = variance[X] + variance[Y]$

  - $
      variance[X + Y] &= expect[(X + Y)^2] - (expect[X + Y])^2 \
      &= expect[X^2 + 2X Y + Y^2] - (expect[X] + expect[Y])^2 \
      &= expect[X^2] + 2 expect[X Y] + expect[Y^2] - ((expect[X])^2 + 2 expect[X] expect[Y] + (expect[Y])^2) \
      &= expect[X^2] - (expect[X])^2 + expect[Y^2] - (expect[Y])^2 + 2 expect[X Y] - 2 expect[X] expect[Y] \
      &= expect[X^2] - (expect[X])^2 + expect[Y^2] - (expect[Y])^2 \
      &= variance[X] + variance[Y]
    $

- For $n$ random variables $X_i$ that satisfies $expect[X_i X_j] = expect[X_i] expect[X_j]$ with $1 <= i < j <= n$

  - For all $k$ such that $1 <= k <= n$, $
expect[(sum _(i = 1) ^k X_i) X_(k + 1)] &= expect[sum _(i = 1) ^k X_i X_k] \
&= sum _(i=1) ^k expect[X_i] expect[X_k] \
&= (sum _(i=1) ^k expect[X_i]) expect[X_k] \
&= expect[(sum _(i = 1) ^k X_i)] expect[X_k]
$

  - $
      variance[X] &= variance[(sum_(i = 1)^(n - 1) X_i) + X_n] = variance[(sum_(i = 1)^(n - 1) X_i)] + variance[X_n] \
      &= variance[(sum_(i = 1)^(n - 2) X_i) + X_(n - 1)] + variance[X_n] = variance[(sum_(i = 1)^(n - 2) X_i)] + variance[X_(n - 1)] + variance[X_n] \
      &dots\
      &= variance[X_1 + X_2] + sum_(i = 3)^n variance[X_i] = variance[X_1] + variance[X_2] + sum_(i = 3)^n variance[X_i] \
      &= sum_(i = 1)^n variance[X_i]
    $

== 3.20

=== Upper bound: $Pr[Y != 0] <= expect[Y] $

- $
    Pr[Y != 0] &= Pr[Y >= 1] &"(Y has nonnegative integer-value)" \
    &<= E[Y] / 1 = E[Y] &"(Markov's Inequality)"
  $

=== Lower bound: $Pr[Y != 0] >= (expect[Y]) ^ 2 / expect[Y^2]$

- Let $Z$ be a positive-valued integer random variable

  - That satisfies $Pr(Z = k) = (Pr(Y = k))/Pr(Y != 0)$ for all positive integer $k$

- $
    expect[Z]
    &= sum_(k = 1)^n k dot Pr(Y = k) / (Pr(Y != 0)) \
    &= 1 / (Pr(Y != 0)) sum_(k = 1)^n k dot Pr(Y = k) \
    &= 1 / (Pr(Y != 0)) sum_(k = 0)^n k dot Pr(Y = k) \
    &= 1 / (Pr(Y != 0)) times expect[Y]
  $

- $
    expect[Z^2]
    &= sum_(k = 1)^n k^2 dot Pr(Y = k) / (Pr(Y != 0)) \
    &= 1 / (Pr(Y != 0)) sum_(k = 1)^n k^2 dot Pr(Y = k) \
    &= 1 / (Pr(Y != 0)) sum_(k = 0)^n k^2 dot Pr(Y = k) \
    &= 1 / (Pr(Y != 0)) times expect[Y^2]
  $

- $
    variance[Z] >= 0 &<=> expect[Z^2] >= (expect[Z])^2 \
    &<=> 1 / (Pr(Y != 0)) times expect[Y^2] >= (1 / (Pr(Y != 0)) times expect[Y])^2 \
    &<=> Pr(Y != 0) >= (expect[Y])^2 / expect[Y^2]
  $

== 3.26

- Let $X = 1/ n sum _(i = 1) ^n X_i$

  - $ expect[X] = 1 / n sum_(i = 1)^n expect[X_i] = (n mu) / n = mu $

  - $ variance[X] = 1 / n^2 sum_(i = 1) expect[X_i] = (n sigma^2) / n^2 = sigma^2 / n $

- $
    Pr(|X - mu| > epsilon) <= variance(X) / epsilon^2 = sigma^2 / (n epsilon^2) &"(Chebyshev's inequality)"\
    lim_(n -> infinity) Pr(|X - mu| > epsilon) <= lim_(n -> infinity) sigma^2 / (n epsilon^2) = 0
  $