#import "../../templates/template-assignment.typ": *
#import "../../utils/utils.typ": *
#import "../utils.typ": *

#show: template-assignment.with(
  title: "Assignment 7",
  student_id: "2023-12675",
  author: "박지호",
)

== 7.2

- $ P _(0, 0) ^0 = 1 $

- $
  P _(0, 0) ^t 
  &= p times P_(0, 0)^(t - 1) + (1 - p) times P_(0, 1)^(t - 1) \
  &= p times P_(0, 0)^(t - 1) + (1 - p) times (1 - P_(0, 0)^(t - 1)) \
  &= (2p - 1) P_(0, 0)^(t - 1) + (1 - p)
$

- $
  (P _(0, 0) ^t  - 1 / 2) 
  &= (2p - 1) (P _(0, 0) ^(t - 1) - 1 / 2) \
  &= (2p - 1)^t (P _(0, 0)^0 - 1 / 2)  = 1 / 2 (2p - 1)^t \
$

- $ therefore P_(0, 0)^t &= 1/2 (1 + (2p - 1)^t) $

== 7.6

- Let:

  - $Y_j$: The position after moving $j$ times

  - $Z_k$: The number of moves to reach $n$ starting from position $k$
  
- Conditional probability for $Y_j$

  - $Y_0 = i$

  - $Pr(Y_(j + 1) = 0 | Y_j = 0) = Pr(Y_(j + 1) = 1 | Y_j = 0) = 1 / 2$

  - $Pr(Y_(j + 1) = k + 1 | Y_j = k) = Pr(Y_(j + 1) = k - 1 | Y_j = k) = 1 / 2 #h(0.5em) (k != 0)$

- Recurrence relation for $expect[Z_k]$

  - $expect[Z_n] = 0$

  - $expect[Z_k] = 1 / 2 expect[Z_(k - 1) + 1] + 1 / 2 expect[Z_(k + 1) + 1] = 1 / 2 (expect[Z_(k - 1)] + expect[Z_(k + 1)]) + 1 #h(0.5em) (k != 0)$
  
    - $1/2$ chance to move to $k - 1$, from which $Z_(k - 1)$ more moves are required

    - $1/2$ chance to move to $k + 1$, from which $Z_(k + 1)$ more moves are required
  
  - $ expect[Z_0] = 1 / 2 expect[Z_0 + 1] + 1 / 2 expect[Z_1 + 1] <=> expect[Z_0] = expect[Z_1] + 2$

    - $1/2$ chance to move to $0$, from which $Z_0$ more moves are required

    - $1/2$ chance to move to $1$, from which $Z_1$ more moves are required

- From the second equation, we can get $
  expect[Z_k] - expect[Z_(k + 1)]
  &= expect[Z_(k - 1)] - expect[Z_k] + 2 \
  &= expect[Z_0] - expect[Z_1] + 2k = 2k + 2
$

  - $ 
    expect[Z_k] 
    &= expect[Z_n] + sum _(t = n) ^(k + 1) (expect[Z_(t - 1)] - expect[Z_t]) \
    &= expect[Z_n] + 2 sum _(t = n) ^(k + 1) t \
    &= 0 + n(n + 1) - k(k + 1) \
    &= (n - k)(n + k + 1)
  $
  
- $ therefore expect[Z_i] = (n - i)(n + i - 1) $
  

== 7.12

=== The Markov Chain

- Let $Y_n := X_n mod k$

  - $X_0 = 0, Y_0 = 0$

- $Y_0, Y_1, dots, Y_n$ is a Markov chain

  - $ 
    because 
    &Pr(Y_t = a_t | Y_(t - 1) = a_t, dots, Y_0 = a_0) 
    = Pr(Y_t = a_t | Y_(t - 1) = a_(t - 1)) \
    &= sum_(#center-align-block[
        $1 <= l <= 6$\
        $l equiv a_t - a_(t - 1)  (mod k)$
      ]) 1 / 6 
  $

    - Rolling $l$ makes state $a_(t - 1)$ transition to $a_t$ if $l equiv a_t - a_(t - 1) (mod k)$
  
  - The value of $Y_t$ is only dependent on $Y_(t - 1)$ and not the sequence $Y_0, dots, Y_(t - 1)$

=== Existence of Stationary Distribution

- The Markov chain is:

  - Finite: $Y_t in {0, 1, dots, k - 1}$

  - Irreducible: For any two states $a$ and $b$, without loss of generality, if $a > b$
  
    - $P_(b, a) ^(a - b) >= (1 / 6)^(a - b)$ (Getting $(a - b)$ 1s in a row)

    - $P_(a, b) ^(k - a + b) >= (1 / 6)^(k - a + b)$ (Getting $(k - a + b)$ 1s in a row)

  - Ergodic: 

    - Aperiodic:

      - If there exists a state $a$ that is periodic with cycle $Delta$

        - $P_(a, a)^k >= (1/6)^k$ (Getting $k$ 1s in a row)
      
        - $P_(a, a)^(k - 1) >= (1 / 6)^(k - 1)$ (Getting $k - 2$ 1s in a row, then 2)

        - $Delta | k$ and $Delta | (k - 1) => Delta | 1$
        
        - $perp$

      - $therefore$ The chain is aperiodic

    - The chain is finite, irreducible, and aperiodic.
    
      - $therefore$ The chain is also ergodic.

- Since the chain is finite, irreducible, and ergodic, the chain has a stationary distribution $overline(pi)$

=== Calculating the Stationary Distribution

- Proposition: $
  overline(pi) = mat(delim: "[", pi_0, pi_1, dots, pi_(k - 1)) = mat(delim: "[", 1/k, 1/k, dots, 1/k)
$

- Let $upright(bold(P))$: The probability matrix for the chain

  - $ 
    P_(i j) = sum_(#center-align-block[
      $1 <= l <= 6$\
      $l equiv j - i (mod k)$
    ]) 1 / 6 
    = 1 / 6 sum_(#center-align-block[
      $1 <= l <= 6$\
      $l equiv j - i (mod k)$
    ]) 1
  $

- $ overline(pi) P = overline(pi) $

  - $
    because
    (overline(pi) bold(upright(P)))_j
    &= 1 / k sum_(i = 0)^(k - 1) P_(i j) \
    &= 1 / (6k) sum_(i = 1)^n sum_(#center-align-block[
      $1 <= l <= 6$\
      $l equiv j - i (mod k)$
    ]) 1 \
    &= 1 / (6k) sum_(l = 1)^6 sum_(#center-align-block[
      $0 <= i <= k - 1$\
      $l equiv j - i (mod k)$
    ]) 1 \
    &= 1 / (6k) sum_(l = 1)^6 1 (because "There is exactly "1" "i" that satisfies the condition") \
    &= 1 / k
  $

  - $therefore$ $overline(pi)$ is a stationary distribution

=== The Answer

- $ therefore lim_(n -> infinity) Pr(X_n" is divisible by "k) = lim_(n -> infinity) Pr(Y_n = 0) = lim_(n -> infinity) P_(0, 0)^n = pi_0 = 1 / k $

== 7.13

=== (a) 

- $
  Pr(X_k = a_k | X_(k + 1) = a_(k + 1), X_(k + 2) = a_(k + 2), dots, X_m = a_m)
  = Pr(X_k = a_k | X_(k + 1) = a_(k + 1)) \
  = (Pr(X_(k + 1) = a_(k + 1) | X_k = a_k) Pr(X_k = a_k)) / Pr(X_(k + 1) = a_(k + 1)) \
  = P_(a_k, a_(k + 1)) times Pr(X_k = a_k) / Pr(X_(k + 1) = a_(k + 1))
$

  - The second term of the multiplication is constant

- $therefore$ The value of $X_k$ is only dependent on $X_(k + 1)$ and not the sequence $X_m, dots, X_(k + 1), X_k$

=== (b)

- Assuming that the chain started from a stationary distribution $overline(pi)$ on time $0$

  - Otherwise, the reverse chain is not time-homogeneous, and $Q_(i, j)$ cannot be defined independent of $k$

  - $forall k, Pr(X_k = a_k) = pi_(a_k)$

- From the equation derived in (a), we get

  - $ 
    Q_(i, j) 
    = Pr(X_k = j | X_(k + 1) = i) 
    = P_(j, i) times Pr(X_k = j) / Pr(X_(k + 1) = i)
    = (pi_j P_(j, i)) / pi_i 
  $

=== (c)

- $ Q_(i, j) = (pi_j P_(j, i)) / pi_i = P_(i, j) $

== 7.17

- Assuming $p > 0$

  - If $p = 0$, states cannot be positive recurrent, since the chain can only move up
  
- Let $X_0, dots, X_t$: The given Markov chain

- Starting from $i$, the chain can either go down or go up in the first step

  - $
    r_(X, i, i)^t = (1 - p) r_(X, i - 1, i) ^(t - 1) + p r_(X, i + 1, i)^(t - 1) \
    h_(X, i, i) = 1 + (1 - p) h_(X, i - 1, i) + p h_(X, i + 1, i)
  $

=== If the chain goes down in the first step

- Let $Y_0, Y_1, dots, Y_t$: A Markov chain with the following properties

  - $Y_t in {0, 1, dots, k}$

  - $Pr(Y_(t + 1) = 1 | Y_t = 0) = 1$

  - $Pr(Y_(t + 1) = i + 1 | Y_t = i) = p, Pr(Y_(t + 1) = i - 1 | Y_t = i) = 1 - p #h(0.5em) (0 < i < k)$

  - $Pr(Y_(t + 1) = k - 1 | Y_t = k) = 1$

- The chain $Y$ is equivalent to the lower part of given chain $X$ except for the state $k$, which is reflective

- $
  r_(Y, i - 1, i)^t = r_(X, i - 1, i)^t\
  h_(Y, i - 1, i) = h_(X, i - 1, i)
$

  - $because$ The chains $X$ and $Y$ cannot differ before reaching $i$

- The chain is:

  - Finite: $Y_t in {0, 1, dots, k}$

  - Irreducible: For any two states $a$ and $b$, without loss of generality, if $a > b$

    - $P_(a, b)^(a - b) = (1 - p)^(a - b)$ (The chain goes down $a - b$ times)

    - $P_(b, a)^(a - b) = p^(a - b)$ (The chain goes up $a - b$ times)

  - Since the chain is finite and irreducible, every state in the chain is positive recurrent

- $
  sum_(t >= 1) r _(Y, i - 1, i) ^(t - 1)
  = sum_(t >= 1) r _(Y, i, i) ^t
  = 1 \
  h_(Y, i - 1, i)
  = h_(Y, i, i) - 1
  < infinity
$

=== If the chain goes up in the first step

- Let $Z_0, dots, Z_t$: A Markov chain with the following properties

  - $Z_t in {k, k + 1, dots}$

  - $Pr(Z_(t + 1) = i + 1 | Z_t = i) = p, Pr(Z_(t + 1) = i - 1 | Z_t = i) = 1 - p #h(0.5em) (i > k)$

  - $Pr(Z_(t + 1) = k + 1 | Z_t = k) = 1$

- $
  r_(Z, i + 1, i)^t = r_(Z, i + 1, i)^t\
  h_(Z, i + 1, i) = h_(Z, i + 1, i)
$

==== Catalan number

- Let $C_n$: The number of ways to arrange $n$ ups and $n$ downs so that the number of ups is greater than or equal to the number of down at any given point in the sequence

  - The Catalan number

- Recurrence relation for $C_n$

  - If $2(i + 1)$ is the first point in the sequence where there are equal number of ups and downs

    - The first move should be up

    - There are $C_i$ ways to arrange the $2i$ moves from the 2nd to $2i + 1$-th move, since these moves should have the following properties to ensure that $2(i + 1)$ is the following properties 

      - Among these $2i$ moves, there should be $i$ ups and $i$ downs, because there should be equal number of ups and downs by the $2(i + 1)$-th move

      - Among these $2i$ moves, the number of ups is greater than or equal to the number of downs at any given point, because otherwise there $2(i + 1)$ is not the first point where there are equal number of ups and downs

    - The $2(i + 1)$-tg move should be down

    - There are $C_(n - i)$ moves to arrange the remaining $2(n - i)$ moves, since these moves should also have the following properties

      - Among these $2(n - i)$ moves, there should be $n - i$ ups and $n - i$ downs since there should be equal number of ups and downs by the end

      - Among these $2(n - i)$ moves, the number of ups is greater than or equal to the number of downs at any given point.

    - There are $C_i C_(n - i)$ ways to arrange moves in a way to follow the condition

  - $ C_(n + 1) = sum _(i = 0)^n C_i C_(n - i) $

- The generating function for $C_n$

  - Let $c(x) := sum_(n = 0)^infinity C_n x^n$

  - $
    c(x)
    &= sum_(n = 0)^infinity C_n x^n \
    &= sum_(n = 0)^infinity sum _(i = 0)^n C_i C_(n - i) x^n \
    &= 1 + x (c(x))^2
  $

    - Solving this, we get $ 
      c(x) = (1 plus.minus sqrt(1 - 4x)) / (2x)
    $

  - Since $C_0 = lim_(x -> 0) c(x) = 1$, $ 
    c(x) = (1 - sqrt(1 - 4x)) / (2x) 
  $

    - The function converges when $0 < x <= 1 / 4$

==== $r_(Z, i, i)^t$

- $
  r_(Z, i, i)^t 
  = cases(
    0 #h(0.5em) &(t = 0),
    p ^(k - 1) (1 - p) ^k C_(k - 1)  #h(0.5em) &(t = 2k, k >= 1),
    0 #h(0.5em) &(t = 2k + 1)
  )
$

- $
  sum_(t >= 1) r_(Z, i + 1, i)^(t - 1) 
  &= sum_(t >= 1) r_(Z, i, i)^t \
  &= sum_(k >= 1) p ^(k - 1) (1 - p) ^k C_(k - 1) = (1 - p) sum_(k >= 1) C_(k - 1) (p(1 - p)) ^(k - 1) \
  &= (1 - p) times c(p (1 - p)) \
  &= (1 - sqrt(1 - 4p(1 - p))) / (2p) = (1 - abs(1 - 2p)) / (2p) \
  &= cases(
    1 #h(0.5em) &(p <= 1 /2),
    (1 - p) / p < 1 #h(0.5em) &(p > 1 /2)
  )
$

- For $p <= 1 / 2$, $
  h_(Z, i + 1, i) 
  &= h_(Z, i, i) - 1 \
  &= sum_(t >= 1) t r_(Z, i, i)^t - 1 = sum_(k >= 1) 2k r_(Z, i, i)^t - 1 \
  &= 2 sum_(k >= 1) k p ^(k - 1) (1 - p) ^k C_(k - 1) = 2 (1 - p) sum_(k >= 1) (k - 1 + 1) C_(k - 1) (p(1 - p))^(k - 1) - 1 \
  &= 2(1 - p) (c'(p(1 - p)) + c(p(1 - p))) - 1 \
$

  - $c'(x) = (-2 x - sqrt(1 - 4 x) + 1)/(2 x^2 sqrt(1 - 4 x))$

  - The value converges when $x < 1 / 4 (p != 1 / 2)$ , and diverges when $x = 1 / 4 (p = 1 / 2)$

=== Conclusion

- When $p < 1 / 2$

  - $
    sum_(t >= 1) r_(X, i, i)^t 
    &= (1 - p) sum_(t >= 1) r_(X, i - 1, i) ^(t - 1) + p sum_(t >= 1) r_(X, i + 1, i)^(t - 1) \
    &= (1 - p) sum_(t >= 1) r_(Y, i - 1, i) ^(t - 1) + p sum_(t >= 1) r_(Z, i + 1, i)^(t - 1) \
    < 1
  $

  - Every state is transient

- When $p = 1 / 2$

  - $
    sum_(t >= 1) r_(X, i, i)^t 
    &= (1 - p) sum_(t >= 1) r_(X, i - 1, i) ^(t - 1) + p sum_(t >= 1) r_(X, i + 1, i)^(t - 1) \
    &= (1 - p) sum_(t >= 1) r_(Y, i - 1, i) ^(t - 1) + p sum_(t >= 1) r_(Z, i + 1, i)^(t - 1) \
    = 1
  $

  - $ 
    h_(X, i, i) 
    &= 1 + (1 - p) h_(X, i - 1, i) + p h_(X, i + 1, i) \
    &= 1 + (1 - p) h_(Y, i - 1, i) + p h_(Z, i + 1, i) \
    &= infinity
  $

  - Every state is null recurrent

- When $p > 1 / 2$

  - $
    sum_(t >= 1) r_(X, i, i)^t 
    &= (1 - p) sum_(t >= 1) r_(X, i - 1, i) ^(t - 1) + p sum_(t >= 1) r_(X, i + 1, i)^(t - 1) \
    &= (1 - p) sum_(t >= 1) r_(Y, i - 1, i) ^(t - 1) + p sum_(t >= 1) r_(Z, i + 1, i)^(t - 1) \
    = 1
  $

  - $ 
    h_(X, i, i) 
    &= 1 + (1 - p) h_(X, i - 1, i) + p h_(X, i + 1, i) \
    &= 1 + (1 - p) h_(Y, i - 1, i) + p h_(Z, i + 1, i) \
    &< infinity
  $

  - Every state is postiive recurrent
  
== 7.21

=== Existence of Stationary Distribution

- Let $X_0, dots, X_t$: The given Markov chain

- The Markov chain is

  - Finite: $X_t in {0, dots, n}$

  - Irreducible: For any two states $a$ and $b$

    - $P_(b, a)^(a + 1) = (1/2)^(a + 1)$ (Go to $0$, then go up $a$ times)

    - $P_(a, b)^(b + 1) = (1/2)^(b + 1)$ (Go to $0$, then go up $b$ times)

  - Ergodic:

    - Aperiodic:

      - If there exists a state $a$ that is periodic with cycle $Delta$

        - $P_(a, a)^(a + 1) = (1 / 2) ^(a + 1)$ (Go to 0, then go up $a$ times)

        - $P_(a, a)^(a + 2) = (1 / 2) ^(a + 2)$ (Go to 0 twice, then go up $a$ times)

        - $Delta | a + 1$ and $Delta | a + 2 => Delta | 1$

        - $perp$

      - $therefore$ The chain is aperiodic

    - The chain is finite, irreducible, and aperiodic.
    
      - $therefore$ The chain is also ergodic.

  - Since the chain is finite, irreducible, and ergodic, the chain has a stationary distribution $overline(pi)$

=== Calculating the Stationary Distribution

- Proposition: $
  overline(pi) = mat(delim: "[", pi_0, pi_1, dots, pi_(k - 1)) = mat(delim: "[", 1 / 2, 1 / 4, 1 / 8, dots, 1 / 2^(n - 1), 1 / 2^(n - 1)) \
$

  - $
    pi_i = cases(
      1 / 2^(i + 1) #h(0.5em) &(i < n),
      1 / 2^n #h(0.5em) &(i = n)
    )
  $ 

- The probability matrix for the chain: $
  bold(upright(P)) = mat(
    delim: "[",
    1 / 2, 1 / 2, 0, 0, dots, 0;
    1 / 2, 0, 1 / 2, 0, dots, 0;
    dots.v, dots.v, dots.v, dots.v, dots.down, dots.v;
    1 / 2, 0, 0, 0, dots, 1 / 2;
    1 / 2, 0, 0, 0, dots, 1 / 2;
  )
$

- $
  overline(pi) upright(bold(P)) = overline(pi) 
$

  - $
    because (overline(pi) P)_j
    = sum_(i = 0)^n pi_i P_(i j)
    = cases(
      sum_(j = 0)^n pi_i times 1 / 2 = 1 / 2 #h(0.5em) &(j = 0), 
      pi_(j - 1) times 1 / 2 = 1 / 2^(j + 1) #h(0.5em) &(0 < j < n), 
      pi_(n - 1) times 1 / 2 + pi_n times 1 / 2 = 1 / 2^n #h(0.5em) &(j = n)
    )
  $

  - $therefore$ $overline(pi)$ is a stationary distribution

=== The Answer

- $ overline(pi) = mat(delim: "[", 1 / 2, 1 / 4, 1 / 8, dots, 1 / 2^n, 1 / 2^n) $

