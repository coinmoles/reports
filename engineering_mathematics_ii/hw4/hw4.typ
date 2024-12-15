#import "../../templates/template-assignment.typ": *
#import "../utils.typ": *

#show: template-assignment.with(
  title: "Assignment 4",
  student_id: "2023-12675",
  author: "박지호",
)

== 4.2

- Let $
X_i = cases(
  0 #h(0.5em) &("if the result of "i"-th dice roll is 6"),
  1 #h(0.5em) &("otherwise"))
$

  - $ expect[X_i] = 1 / 6 $

  - $ variance[X_i] = expect[X_i^2] - (expect[X_i])^2 = 1 / 6 - 1 / 36 = 5 / 36 $

- $ X = sum_(i = 1)^n X_i $

  - $ expect[X] = n times 1 / 6 $

  - $ variance[X] = n times 5 / 36 $

  - $ sigma[X] = sqrt((5n) / 36) $

- Markov's inequality:

  - $ p = Pr[X >= n / 4] <= expect[X] / (n / 4) = 2 / 3 $

  - The bound obtained with Markov's inequality is constant with respect to $n$, and isn't too practical

- Chevyshev's inequality:

  - $ p = Pr[X >= n / 4] = Pr[ abs(X - n / 4) >= n / 12] <= (variance[X]) / (n / 12)^2 = 20 / n $

  - The bound obtained by Chebyshev's inequality gets smaller as $n$ grows, and for a $n$ larger than 30, is smaller than the bound from Markov's inequality

- Chernoff bound (Using the formula for the sum of Poisson trials)

  - $
      p = Pr[X >= n / 4] = Pr[X >= (1 + 1 / 2) expect[X]] <= ((e^(1 / 2)) / (1 + 1 / 2)^(1 + 1 / 2))^(n / 6) = ((8e) / 27)^(n / 12)
    $

  - The Chernoff bound gets exponentially smaller as $n$ grows, and for a large enough $n$ it is smaller than both Markov's inequality bound and Chebyshev's inequality bound.

- Chernoff bound (General)

  - We'll use the moment generating function from 4.3.(a)

  - $ p = Pr[X >= n / 4] <= min_(t > 0) (1 / 6 e^t + 5 / 6)^n e^(-1 / 4n t) $

  - $
      &dif / (dif t) ((1 / 6 e^t + 5 / 6)^n e^(-1 / 4n t)) = 0 \
      &<=> 1 / 6 n e^t (1 / 6 e^t + 5 / 6)^(n - 1) e^(-1 / 4n t) - 1 / 4 n (1 / 6 e^t + 5 / 6)^n e^(-1 / 4n t) = 0 \
      &<=> 1 / 6 e^t - 1 / 4 (1 / 6 e^t + 5 / 6) = 0 \
      &<=> 1 / 8 e^t - 5 / 24 = 0 \
      &<=> e^t = 5 / 3 \
      &<=> t = ln 5 / 3 > 0
    $

    - For this $t$, we get $ Pr[X >= n / 4] <= ((2^4 times 5 ^3)/ 3^7)^(n/4) $

  - $ ((8e) / 27)^(1 / 12) approx 0.9821, ((2^4 times 5^3) / 3^7)^(1 / 4) approx 0.9779 $

  - This bound also gets exponentially smaller as $n$ grows, and is better than the Poisson-specific version.

== 4.3

=== (a)

- Let $X$ be the binomial random variable with the distribution of $upright(bold(B))(n, p)$

  - We can represent $X$ as $ X = sum_(i = 1)^n X_i $

  - Where $X_i$s are the independent random variables with the distribution of $bold("Bernoulli"(p))$

- $
    M_(X_i)(t) &= expect [e^(t X_i)] \
    &= p times e^(t) + (1 - p) times e^0
  $

  - $ M_X(t) = product_(i = 1)^n M_(X_i) (t) = (1 - p + p e^t)^n $

=== (b)

- $
    M_(X + Y)(t) = M_X (t) times M_Y (t) = (1 - p + p e^t)^n times (1 - p + p e^t)^m = (1 - p + p e^t)^(m + n)
  $

=== (c)

- Let $Z$ be the binomial random variable with the distribution of $upright(bold(B))(m + n, p)$

  - $M_Z (t) = M_(X + Y) (t)$

- $X + Y$ has the same distribution as $Z$

== 4.4

- Let $X$ be the number of heads obtained after $n$ flips

- Explicit calculation:

  - $ Pr(X >= k) = sum_(i = k)^n mat(n;i) (1 / 2)^i (1 / 2)^(n - i) = 1 / 2^n sum_(i = k)^n mat(n;i) $

  - Calculated using the python code in @code #figure(
```python
import math

n = 100 # The number of coin flips
k = 55 # The amount of heads to get
cases = 0

for i in range(k, n + 1):
    cases += math.comb(n, i)

# Dividing at the end to avoid floating point problems
print(cases / (2 ** n))
```,
gap: 1.5em,
caption: [Python code used to calculate the probability explicitly]
) <code>

- Chernoff bound (Using the formula for the sum of Poisson trials)

  - $ expect[X] = n / 2$ (trivial)

  - $ Pr[X >= k] <= Pr [X >= (1 + ((2k) / n - 1)) times n / 2] = (e^((2k) / n - 1) / ((2k) / n)^((2k) / n))^(n / 2) $

- Chernoff bound (General)

  - We'll use the moment generating function from 4.3.(a)

  - $ Pr[X >= k] <= min_(t > 0) (1 / 2 e^t + 1 / 2)^n e^(-k t) $

  - $
      &dif / (dif t) ((1/2 e^t + 1/2)^n e^(-k t)) = 0 \
    &<=> 1/2 n (1/2 e^t + 1/2)^(n - 1) e^(-k t) - k (1/2 e^t + 1/2)^n e^(-k t) = 0 \
    &<=> 1/2 n e^t - k (1/2 e ^t + 1/2) = 0 \
    &<=> e^t = k / (n - k) \
    &<=> t = ln k / (n - k) > 0 #h(1em) ("For given "n, k)
    $

- Getting 55 or more heads from 100 flips

  - Explicit calculation: $0.184100$

  - Chernoff bound (Using the formula for the sum of Poisson trials): $Pr[X >= k] <= 0.785009$

  - Chernoff bould (General): $Pr[X >= k] <= 0.606023$

  - The Chernoff bound is way larger than the actual probability

- Getting 550 or more heads from 1000 flips:

  - Explicit calculation: $8.65268 times 10^(-4)$

  - Chernoff bound (Using the formula for the sum of Poisson trials): $Pr[X >= k] <= 8.88684 times 10^(-2)$

  - Chernoff bould (General): $Pr[X >= k] <= 6.68181 times 10^(-3)$

  - The Chernoff bound is still way larger than the actual probability, and the scale difference is much larger

== 4.9

=== (a)

- Let $n$ be the number of samples

- $ overline(X) = 1 / n sum_(i = 0)^n X_i $

  - $ expect[ #h(0.2em) overline(X) #h(0.2em) ] = 1 / n sum_(i = 0)^n expect[X_i] = expect[X] $

  - $ variance[ #h(0.2em) overline(X) #h(0.2em) ] = 1 / n^2 sum_(i = 0)^n variance[X_i] = 1 / n variance[X] $

- $
    Pr[abs(overline(X) - expect[X] ) >= epsilon expect[X]] >= (1 / n variance[X]) / (epsilon expect[X])^2 = variance[X] / (expect[X])^2 times 1 / (n epsilon^2) = r^2 / (n epsilon^2)
  $

  - $
      Pr[abs(overline(X) - expect[X] ) <= epsilon expect[X]] > 1 - delta
      &<=> Pr[abs(overline(X) - expect[X] ) >= epsilon expect[X]] < delta \
      &arrow.double.l r^2 / (n epsilon^2) < delta \
      &<=> n > r^2 / (delta epsilon^2)
    $

- $upright(O)(r^2 / (delta epsilon^2))$ samples are sufficient to solve the problem

=== (b)

- Applying $delta = 1/4$ to (a)

  - $n > 4 times r^2 / epsilon^2$

- $upright(O)(r^2 / epsilon ^ 2)$ samples are are enough for this estimate

=== (c)

- From (b), we know that with $4 times r^2 / epsilon ^ 2$ samples,
  we can ensure $Pr[abs(overline(X) - expect[X]) <= epsilon expect[X]] >= 3/4$

- Let's say that we repeat this process of picking $4 times r^2 / epsilon ^ 2$ samples
  to gain $m$ estimate values.

  - If more than half of the estimates is within the $epsilon expect [X]$ of $expect[X]$,
    the median is within the $epsilon[X]$ of $expect [X]$

- Let $Y$ be the number of estimates that is within the $epsilon expect[X]$ of $expect[X]$

  - $Y$ follows a binomial distribution $B(m, q)$,
    where $q$ is the probability that each estimate is within the $epsilon expect[X]$ of $expect[X]$

    - We've established that $q > 3/4$

    - $expect[Y] = m q$

  - $
      Pr[Y <= 1 / 2m] &<= min_(t < 0) (1 - q + q e^t)^m / (e^(1 / 2m t)) \
      &= min_(t < 0) ((1 - q) e^(-1 / 2 t) + q e^(1 / 2 t))^m \
    $

    - The minimum value of right hand side is $(2 sqrt(q (1 - q)))^(m)$

    - $Pr[Y <= 1 / 2 m] <= (sqrt(3) / 2)^m (because q > 3 / 4)$

  - $
      Pr[Y > 1 / 2 m] >= 1 - delta &<=> Pr[Y <= 1 / 2 m] < delta \
      & arrow.double.l (sqrt(3) / 2)^m < delta \
      & m > (ln 1 / delta) / ln(2 / sqrt(3))
    $

- By repeating the process to more than $upright(O)(ln 1 / delta)$ times,
  we can ensure that median of estimates is within the $epsilon expect[X]$ of $expect[X]$

- For the entire process, we need $upright(O)(r^2 / epsilon ^ 2)$ samples $upright(O)(ln 1 / delta)$ times.

  - Therefore, we need a total of $upright(O)(r^2 / epsilon ^ 2 ln 1 / delta)$ samples

== 4.10

- Let $X_i$ be the payout of the $i$-th game in dollars

  - $forall i, j$, $X_i$ and $X_j$ are independent

  - $ expect[X_i] = 4 / 25 times 3 + 1 / 200 times 100 = 49 / 50 $

  - $ M_X(t) = expect[e^(X_i t)] = 4 / 25 times e^(3t) + 1 / 200 times e^(100t) $

- Let $X$ be the total payout of the machine over the first million games

  - Let $N = 1,000,000$

  - $ X = sum_(i = 1)^(N) X_i $

  - $ expect[X] = sum_(i = 1)^N expect[X_i] = 49 / 50 N $

  - $
      M_X (t) = product_(i = 1)^(N) M_(X_i) (t)
      = (4 / 25 e^(3t) + 1 / 200 e^(100t))^N
      = e^(3 N t) (1 / 200 e^(97t) + 4 / 25)^N
    $

- The net profit of the machine after $N$ games is $N - X$

  - Let $M = 10,000$

  - $
      Pr[N - X <= -M] = Pr[X >= N + M]
    $

- The Chernoff bound (Using the formula for the sum of Poisson trials):

  - $
      Pr[X >= N + M] <= Pr[X >= (1 + ((50 (N + M)) / (49N) - 1)) times 49 / 50 N]
    $

  - Let $delta = ((50 (N + M)) / (49N) - 1) = 3/98, mu = 980000$

  - The Chernoff bound (Using the formula for the sum of Poisson trials): $
    Pr[X >= N + M] <= (e^delta / (delta + 1)^(delta + 1))^mu = 3.83165 times 10^(-198)
  $

- The Chernoff bound (General):

  - $Pr[X >= N + M] <= min_(t > 0) (M_X (t)) / (e^((N + M) t))
      = min_(t >0) (e^((2 N - M) t) (1 / 200 e^(97t) + 4 / 25)^N)$

  - $
      &dif / (dif t) (e^((2 N - M) t) (1 / 200 e^(97t) + 4 / 25)^N) \
      &= (2N - M) e^((2 N - M) t) (1 / 200 e^(97t) + 4 / 25)^N
      + 97 / 200 N e^(97t) e^((2 N - M) t) (1 / 200 e^(97t) + 4 / 25)^(N - 1) \
      &= ((2N - M)(1 / 200 e^(97t) + 4 / 25) + 97 / 200 N e^(97t))
      times e^((2N - M)t) (1 / 200 e^(97t) + 4 / 25)^(N - 1) \
      &= ((99N - M) / 200 e^(97t) + 4 / 25 (2N - M))
      times e^((2N - M)t) (1 / 200 e^(97t) + 4 / 25)^(N - 1) \
      &>0
    $

    - $
        therefore
        &min_(t >0) (e^((2 N - M) t) (1 / 200 e^(97t) + 4 / 25)^N) \
        &= lim_(t -> 0+) (e^((2 N - M) t) (1 / 200 e^(97t) + 4 / 25)^N) \
        &= (33 / 200)^N approx 9.6085 times 10^(-795881)
      $

  - The Chernoff bound (General): $Pr[X >= N + M] <= 8.7946 times 10^(-782517)$

== 4.13

=== (a)

- If $x = 1$

  - $ Pr[X >= n x] = Pr[X >= n] = p^n = e^(- n F(x, p)) $

- If $p = 0$

  - The given function cannot be defined, so we ignore this case

- Oherwise ($0 < p < x < 1$)

  - The Chernoff bound for $Pr[X >= x n]$

    - $
        M_X_i (t) = p e^t + (1 - p)
      $

    - $
        M_X (t) = product_i^n M_X_i (t) = (p e^t + 1 - p)^n
      $

    - $
        Pr (X >= x n)
        <= min_(t > 0) (p e^t + 1 - p)^n / e^(n x t)
      $

  - $
      &diff / (diff t) ((p e^t + 1 - p)^n / e^(n x t)) = 0 \
      & <=> n p e^t (p e^t + 1 - p)^(n - 1) e^(- n x t) - n x (p e^t + 1 - p)^n e^(-n x t) = 0 \
      &<=> p e^t - x (p e^t + 1 - p) = 0 \
      &<=> p(1 -x) e^t - x(1 - p) = 0 \
      &<=> t = ln x(1 - p) / p(1 - x) \
    $

    - $x / (1 - x)$ is an increasing function for $0 < x < 1$

      - $ 1 > x > p > 0 => x / (1 - x) > p / (1 - p) > 0 => x(1 - p) / p(1 - x) > 1 => t > 0 $

    - For this $t$, the Chernoff bound is $
      Pr (X >= x n)
      &<= (p e^t + 1 - p) ^n / e^(n x t) \
      &= (p times x(1 - p) / p(1 - x) + 1 - p)^n / (x(1 - p) / p(1 - x))^(n x)
      = ((1 - p) / (1 - x))^n / (x(1 - p) / p(1 - x))^(n x) \
      &= (((1 - x)/(1 - p))^(1 - x) (x/p)^x)^(-n) \
      &= e^(- n (x ln x / p + (1 - x) ln (1 - x) / (1 - p)))) = e^(-n F(x, p))
    $

- $therefore Pr (X >= x n) <= e^(- n F(x,p))$

=== (b)

- Let $G(x, p) = F(x, p) - 2(x - p)^2$

  - $
      (diff G) / (diff x)
      &= diff / (diff x) (x ln x / p + (1 - x) ln (1 - x) / (1 - p) - 2(x - p)^2 ) \
      &= ln x / p + 1 - ln (1 - x) / (1 - p) - 1 - 4 (x - p) \
      &= ln x / p - ln (1 - x) / (1 - p) - 4(x - p)
    $

  - $
      (diff^2 G) / (diff x^2)
      &= diff / (diff x) (ln x / p - ln (1 - x) / (1 - p) - 4(x - p)) \
      &= 1 / x + 1 / (1 - x) - 4 \
      &= (1 - x + x - 4x (1 - x)) / x(1 - x) \
      &= (1 - 2x)^2 / x(1 - x) >= 0
    $


- Conjecture: $forall x, p > 0, G(x, p) >= 0$

  - $x = p: G(p, p) = 0 >= 0$, the conjecture holds

    - $
        (diff G) / (diff x) (p, p) = 0
      $

  - $x > p$:

    - $
        (diff G) / (diff x) (x, p)
        = (diff G) / (diff x) (p, p) + integral_p^x (diff^2 G) / (diff x^2) (t, p) dif t >= 0
      $

    - $
        G(x, p)
        = G (p, p) + integral_p^x (diff G) / (diff x) (t, p) dif t >= 0
      $

  - $x < p$:

    - $
        (diff G) / (diff x) (x, p)
        = (diff G) / (diff x) (p, p) + integral_p^x (diff^2 G) / (diff x^2) (t, p) dif t <= 0
      $

    - $
        G(x, p)
        = G (p, p) + integral_p^x (diff G) / (diff x) (t, p) dif t >= 0
      $

- $therefore forall x, p, G(x, p) = F(x, p) - 2(x - p)^2 >= 0$

=== (c)

- $
    Pr[X >= (p + epsilon) n] <= e^(- n F(p + epsilon, p)) <= e^(- n times 2 (epsilon + p - p)^2) = e^(-2 n epsilon^2)
  $

=== (d)

- Conjecture: $forall x < p, Pr[X <= x n] <= e ^ (-n F(x, p))$

  - If $x = 0$

    - $Pr[X <= x n] = Pr [X <= 0] = (1 - p)^n = e^(-n F(x, p))$

  - If $p = 1$

    - The given function cannot be defined, so we ignore this case

  - Otherwise (0 < x < p < 1)

    - The Chernoff bound for $Pr[X <= x n]$

      - $Pr[X <= x n] <= min_(t < 0) (p e^t + 1 - p)^n / e^(n x t)$

    - The value of $t$ that minimizes the right hand side is the same as (a), $t = ln x(1 - p) / p(1 - x)$

      - This time, $t < 0$ since $0 < x < p < 1$

      - The minimum value of the right hand side is also the same as (a)

    - Hence, following the same step as (a), we get $Pr (X >= x n) <= e^(- n F(x,p))$

  - $therefore Pr (X >= x n) <= e^(- n F(x,p))$

- $Pr[X <= (p - epsilon) n] <= e^(- n F(p - epsilon, p)) <= e^(-2 n epsilon^2)$

- $therefore Pr[abs(X - p n) >= epsilon n] = Pr[X <= (p - epsilon) n] + Pr[X >= (p + epsilon) n] <= 2e^(-2 n epsilon^2)$