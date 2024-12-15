#import "../../templates/template-assignment.typ": *
#import "../utils.typ": *

#show: template-assignment.with(
  title: "Assignment 5",
  student_id: "2023-12675",
  author: "박지호",
)

== 5.4

- Count the number of configurations where at most two people share the same birthday

- Let $B_k$: The number of configurations where $k$ pair of people shares the same birthday, and the other $100 - 2k$ people have distinct birthdays

  - Pick $k + 100 - 2k = 100 - k$ days: $binom(365, 100 - k)$

  - Pick $k$ pairs of people $1 / k! product _(i = 0) ^ (k - 1) binom(365 - 2i, 2)$

  - Assign $100 - k$ birthdays: $(100 - k)!$

  - $therefore B_k = 1 / k! binom(365, 100 - k) (100 - k)! product_(i = 0)^(k - 1) binom(365 - 2i, 2)$

- The answer: $
  1 / 365 ^ 100 sum _(k = 0) ^50 B_k
  = 1 / 365 ^ 100 sum _(k = 0) ^50 (1 / k! binom(365, 100 - k) (100 - k)! product _(i = 0) ^ (k - 1) binom(365 - 2i, 2))
$

== 5.9

- The expected time of the first step, where each elements are placed in the appropriate bucket, remains the same as in the case of uniform distribution at $O(n)$

  - Assuming the time to place each element to the appropriate bucket is $O(1)$,

  - Iterating through the entire array and placing each element to the appropriate bucket trivially takes $O(n)$ time

- Let $X_j$ be the number of elements in the $j$-th bucket

  - $X_j ~ B(n, p_j)$

  - When $p_j$ is the probability that any number that would be placed in the $j$-th bin is chosen as an element of the initial array

  - $
      p_j <= sum_(
      #center-align-block[
        $0 <= t < 2^k$ \
        $t equiv j #h(0.3em) (mod n)$
      ]
      )
      q_t
      <= sum_(
      #center-align-block[
        $0 <= t < 2^k$ \
        $t equiv j #h(0.3em) (mod n)$
      ]
      )
      a / 2^k
      approx 2^k / n times a / 2^k
      = a / n
    $

  - When $q_t$ is a probability that $t$ is chosen as an element of the initial array

- The expected time of the second step, where elements in each bucket are sorted, is as follows

  - Assuming the quadratic sorting algorithm used to sort elements in each bucket takes $c n^2$ expected time to sort an array of $n$ elements for a constant $c$

  - The expected time of the second step: $
    expect[sum _(j = 1) ^ n c X_j^2]
    &= c sum _(j = 1) ^n expect[X_j^2]\
    &= c sum _(j = 1) ^n (n(n - 1) p_j^2 + n p_j)\
    &<= c sum _(j = 1) ^n (n(n - 1) (a / n)^2 + n (a / n))\
    &= c n (a^2 - a / n + a) \
    &= O(n)
  $

- The expected time of concatenating the bucket is also trivially $O(n)$

- $therefore$ The overall algorithm required a linear expected time

== 5.10

- Let:

  - $X_i$: The number of balls in the $i$-th bin

  - $Y_i$: $Y_i ~ "Poisson"(1)$

    - $Y_i$ are mutually independent

=== (a)

- $
    Pr((Y_1, dots, Y_n) = (1, dots, 1))
    = product_(i = 1)^n Pr(Y_i = 1)
    = product_(i = 1)^n (e^(-1) times 1^1) / 1!
    = e^(-n)
  $

=== (b)

- Number of configurations where $n$ bins receives exactly one ball: $n!$

  - $because$ First ball can land in any bin ($n$ configurations), second ball can land in any bin that didn't receive the first ball ($n - 1$ configurations), ..., last ball can land in any bin that didn't receive the first ball ($1$ configuration)

- Number of every possible configuration: $n^n$

- $
    therefore Pr((X_1, dots, X_n) = (1, dots, 1)) = n! / n^n
  $

=== (c)

- Let $Y := sum _(i = 1)^n Y_i$

  - $Y ~ "Poisson"(n)$

- From theorem 5.6: $
  Pr((X_1, dots, X_n) = (1, dots, 1))
  &= Pr ((Y_1, dots, Y_n) = (1, dots, 1) mid(|) Y = n) \
  &= Pr((Y_1, dots, Y_n) = (1, dots, 1), Y = n) / Pr(Y = n) \
  &= Pr((Y_1, dots, Y_n) = (1, dots, 1)) / Pr(Y = n)
$

  - $
      therefore Pr((Y_1, dots, Y_n) = (1, dots, 1)) / Pr((X_1, dots, X_n) = (1, dots, 1))
      = Pr(Y = n)
    $

  - The two probabilities differ by a multiplicative factor of the probability that a Poisson random variable with parameter $n$ takes on the value $n$

- Dividing the answer to the two previous problems yields a result consistent with this: $
  "(a)" / "(b)" = (e^(-n) times n^n) / n!
$

== 5.12

=== (a)

- Let:

  - $ Y_i := cases(0 &"if ball" i "is removed", 1 &"if ball" i "remains") $

  - $Y$: The number of balls at the start of next round

    - $Y = sum_(i = 1)^n Y_i$

- For ball $i$ to be removed, $b - 1$ other balls should land in a different bin

  - $Pr(Y_i = 0) = (1 - 1 / n)^(b - 1), Pr(Y_i = 1) = 1 - (1 - 1 / n)^(b - 1)$

  - $expect[Y_i] = 1 - (1 - 1 / n)^(b - 1)$

- $expect[Y] = sum_(i = 1)^b expect[Y_i] = b(1 - (1 - 1 / n)^(b - 1))$

=== (b)

- Let:

  - $x_j$: The number of balls after the $j$-th round, given exactly expected number of balls are removed each round

- $
    x_(j + 1)
    &= x_j (1 - (1 - 1 / n)^(x_j - 1)) \
    &<= x_j (1 - (1 - (x_j - 1) / n)) \
    &= (x_j (x_j - 1)) / n <= x_j^2 / n
  $

- Special cases:

  - $x_1 = n(1 - (1 - 1 / n)^(n - 1)) approx n (1 - e^(-1 / n (n - 1))) <= n(1 - 1 / e)$

  - $ 0 <= x_k <= 1 => x_(k + 1) <= max_(0 <= a <= 1) a(a - 1) / n = 0 => x_(k + 1) = 0 $

- From this equation, we get: $
  x_(j + 1) / n &<= (x_j / n)^2 \
  x_k / n &<= (x_(k - 1) / n)^2 <= dots <= (x_1 / n)^2^(k - 1) = (1 - 1 / e)^(2^(k - 1))
$

- If $k - 1 >= log _2 log_(e / (e - 1)) n = 1 / (ln 2 ln (e / (e - 1))) ln ln n$

  - $ x_k / n <= 1 / n => x_k <= 1 $

  - $ x_(k + 1) = 0 $

- $therefore$ All balls would be served after a maximum of $1 / (ln 2 ln (e / (e - 1)))  ln ln n + 2 = O(log log n)$ rounds

== 5.14

=== (a)

- For an integer $k <= mu - 1$, $Pr(Z = k) <= Pr(Z = 2mu - k - 1)$

  - Proof: $
    (2mu - k - 1)! / k!
    &= (k + 1)(k + 2) dots (2mu - k - 1) \
    &= mu times (mu - 1) (mu + 1) times (mu - 2) (mu + 2) dots times (mu + (mu - k - 1)) (mu - (mu - k - 1)) \
    &= mu times product _(i = 1) ^(mu - k - 1) (mu - i)(mu + i) \
    &<= mu times product _(i = 1) ^(mu - k - 1) mu^2 \
    &= mu^(2mu - 2k - 1) \

    therefore Pr(Z = k) &= (e^(-mu) mu^k) / k! <= (e^(-mu) mu^(2mu - k - 1)) / (2mu - k - 1)! = Pr(Z = 2mu - k - 1)
  $

- From this formula, when $k = mu - h - 1$:

  - $Pr(Z = μ + h) ≥ Pr(Z = μ − h − 1)$

=== (b)

- $
    Pr(Z <= mu - h - 1)
    &= sum_(k = 0)^(mu - h - 1) Pr(Z = k) \
    &<= sum_(k = 0)^(mu - h - 1) Pr(Z = 2mu - k - 1) \
    &= sum_(k = mu + h)^(2mu - 1) Pr(Z = k) \
    &<= sum_(k = mu + h)^infinity Pr(Z = k) \
    &= Pr(Z >= mu + h)
  $

  - $therefore forall h; 0 <= h <= mu - 1, Pr(Z >= mu + h) >= Pr(Z <= mu - h - 1)$

- From this formula, when $h = 0$:

  - $Pr(Z >= mu) >= Pr(Z <= mu - 1)$

- Since $Pr(Z >= mu) + Pr(Z <= mu - 1) = 1$

  - $Pr(Z >= mu) >= 1 / 2$

== 5.16

=== (a)

- Proposition: $forall i_1, dots, i_k subset {1, dots, n} #h(0.2em) ("allowing repeat")$, $expect[product _(m = 1)^k X_i_m] <= expect[product _(m = 1)^k Y_i_m]$

  - Let ${j_1, dots, j_t} = {i_1, dots, i_k} #h(0.2em) ("set of unique elements in" i_1, dots, i_k) $

  - Proof: $
    expect[product _(m = 1)^k X_i_m = 1]
    = Pr(product _(m = 1)^k X_i_m = 1)
    = Pr(sect.big _(m = 1)^t X_j_t = 1)
    = (1 - t / n)^n \

    expect[product _(m = 1)^k Y_i_m = 1]
    = Pr(product _(m = 1)^k Y_i_m =  1)
    = Pr(sect.big _(m = 1)^t Y_j_m = 1)
    = product _(m = 1)^t Pr(Y_j_m = 1)
    = (1 - 1 / n)^(t n) \

    therefore expect[product _(t = 1)^k X_i_t = 1] <= expect[product _(t = 1)^k Y_i_t = 1]
    (because forall t >= 1, #h(0.5em) 1 - t / n <= (1 - 1 / n)^t)
  $

- The given inequality naturally holds from this when $i_1 = 1, dots, i_k = k$

  - $ expect[product_(m = 1)^k X_m] <= expect[product_(m = 1)^k Y_m] $

=== (b)

- Proposition: $expect[X ^k] <= expect[Y ^k]$ for all $k$

  - Proof: $
    expect[X^k]
    &= expect[(sum _(i = 1)^n X_i)^k] \
    &= sum _(i_1, dots, i_n in {1, dots, n}) expect[product_(m = 1)^n X_i_m] \
    &<=sum _(i_1, dots, i_n in {1, dots, n}) expect[product_(m = 1)^n Y_i_m] #h(0.5em) &(because "inequality proved in (a)") \
    &= expect[(sum _(i = 1)^n Y_i)^k] \
    &= expect[Y^k]
  $

- $
    expect[e^(t X)]
    &= expect[sum_(k = 0)^infinity 1 / k! (t X)^k]
    &= sum_(k = 0)^n 1 / k! t^k expect[X^k]
    &<= sum_(k = 0)^n 1 / k! t^k expect[Y^k]
    &= expect[sum_(k = 0)^infinity 1 / k! (t Y)^k] = expect[e^(t Y)]
  $

- $therefore expect[e^(t X)] <= expect[e^(t Y)]$

=== (c)

- $
    expect[X] = expect[sum_(i = 1)^n X_i] = sum_(i = 1)^n expect[X_i] = n (1 - 1 / n)^n \
    expect[Y] = expect[sum_(i = 1)^n Y_i] = sum_(i = 1)^n expect[Y_i] = n (1 - 1 / n)^n
  $

  - $therefore expect[X] = expect[Y]$

- $
    Pr(X >= (1 + delta) expect[X])
  &<= min_(t > 0) expect[e^(t X)] / e^(t (1 + delta) expect[X]) \
  &<= min_(t > 0) expect[e^(t Y)] / e^(t (1 + delta) expect[X]) \
  &= min_(t > 0) expect[e^(t Y)] / e^(t (1 + delta) expect[Y]) \
  &<= (e^delta / (1 + delta)^(1 + delta))^expect[Y] #h(0.5em) &("Chernoff bound for some of Poisson trials") \
  &= (e^delta / (1 + delta)^(1 + delta))^n(1 - 1/n)^n
  $

- $therefore$ The Chernoff bound: $
  Pr(X >= (1 + delta) expect[X]) <= (e^delta / (1 + delta)^(1 + delta))^n(1 - 1/n)^n
$