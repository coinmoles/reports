#import "../../templates/template-assignment.typ": *
#import "../../utils/utils.typ": *
#import "../utils.typ": *

#show: template-assignment.with(
  title: "Assignment 8",
  student_id: "2023-12675",
  author: "박지호",
)

== Exercise 8.1.
Let $X$ and $Y$ be independent, uniform random variables on $[0, 1]$. Find the density function and distribution function for $X + Y$

=== Solution

- Let $Z := X + Y$

- The density and distribution function for $X$ and $Y$

  - Distribution function: $
      F_X (x)
      = F_Y(x)
      = cases(0 #h(0.5em) &(x < 0), x #h(0.5em) &(0 <= x <= 1), 1 #h(0.5em) &(1 < x))
    $

  - Density function: $
      f_X (x) = f_Y (x) =
      cases(0 #h(0.5em) (x < 0), 1 #h(0.5em) (0 <= x <= 1), 0 #h(0.5em) (1 < x))
    $

- $
    F_Z (z)
    &= Pr(Z <= z) \
    &= integral_0^z f_Z (k) dif k
    gap (because forall k < 0, "trivially" f_Z (k) = 0 ) \
    &= integral_0^z (infintegral f_(Z Y) (k, y) dif y) dif k
    = infintegral (integral_0^z f_(Z Y) (k, y) dif k) dif y \
    &= infintegral (integral_0^z f_(Z|Y) (k, y) f_Y (y) dif k) dif y
    = infintegral (integral_0^z f_(Z|Y) (k, y) dif k) f_Y (y) dif y \
    &= infintegral Pr(Z <= z | Y = y) f_Y (y) dif y \
    &= infintegral Pr(X <= z - y | Y = y) f_Y (y) dif y
    = infintegral Pr(X <= z - y) f_Y (y) dif y \
    &= infintegral F_X (z - y) f_Y (y) dif y
    = integral_0^z F_X (z - y) f_Y (y) dif y
  $

  - $z <= 0$:

    - $ F_Z (z) = 0 $

  - $0 < z <= 1$

    - $
        F_Z (z)
        = integral_0^z F_X (z - y) f_Y (y) dif y
        = integral_0^z (z - y) dif y
        = 1 / 2 z^2
      $

  - $1 < z < 2$

    - $
        F_Z (z)
        &= integral_0^z F_X (z - y) f_Y (y) dif y
        = integral_0^(z - 1) 1 dif y
        + integral_(z - 1)^1 (z - y) dif y
        + integral_1^z 0 dif y \
        &= (z - 1) + 1 / 2 (2z - z^2) = 1 - 1 / 2 (2 - z)^2
      $

  - $z >= 2$

    - $ F_Z (z) = 1 $

=== Answer

- Distribution function: $
    F_(X + Y) (z)
    = cases(0 #h(0.5em) &(z < 0), 1 / 2 z^2 #h(0.5em) &(0 <= z <= 1), 1 - 1 / 2 (2 - z)^2 #h(0.5em) &(1 < z <= 2), 1 #h(0.5em) &(2 < z))
  $

- Density function: $
    f_(X + Y) (z)
    = cases(0 #h(0.5em) &(z < 0), z #h(0.5em) &(0 <= z <= 1), (2 - z) #h(0.5em) &(1 < z <= 2), 0 #h(0.5em) &(2 < z))
  $

== Excercise 8.9.
You would like to write a simulation that uses exponentially distributed random variables. Your system has a random number generator that produces independent, uniformly distributed numbers from the real interval $(0, 1)$. Give a procedure that transforms a uniform random number as given to an exponentially distributed random variable with parameter $lambda$.

=== Answer

- $ Y := - (ln (1 - X)) / lambda $

  - $Y tilde e(lambda)$

=== Proof

- $
    F_Y (y)
    &= Pr(Y <= y) \
    &= Pr(- (ln (1 - X)) / lambda <= y) \
    &= Pr(X <= 1 - e^(- lambda y)) \
    &= cases(0 gap &(y < 0) gap (because 1 - e^(- lambda y) < 0), 1 - e^(- lambda y) gap &(y >= 0))
  $

  - $therefore y tilde e(lambda)$

\

== Excercise 8.19.
You are waiting at a bus stop to catch a bus across town. There are actually $n$ different bus lines you can take, each following a different route. Which bus you decide to take will depend on which bus gets to the bus stop first. As long as you are waiting, the time you have to wait for a bus on the $i$-th line is exponentially distributed with mean $mu_i$ minutes. Once you get on a bus on the $i$-th line, it will take you $t_i$ minutes to get across town

Design an algorithm for deciding – when a bus arrives – whether or not you should get on the bus, assuming your goal is to minimize the expected time to cross town. (Hint: You want to determine the set of buses that you want to take as soon as they arrive. There are $2^n$ possible sets, which is far too large for an efficient algorithm. Argue that you need only consider a small number of these sets.)

=== Solution

- Let

  - $X_i$: The time it takes for the bus $i$ to arrive

  - $Z_i$: The time it takes for the bus $i$ to cross the town

    - $Z_i = X_i + t_i$

  - $Z$: The expected time to cross the town (when no bus has arrived at the moment)

    - $Z = min(Z_1, Z_2, dots, Z_n)$

    - $Z > 0$

  - Without loss of generality, $t_1 <= t_2 <= dots < t_n$

    - $t_0 = 0, t_(n + 1) = infinity$

- $
    Pr(Z >= z)
    &= Pr(min(Z_1, dots, Z_n) >= z) \
    &= Pr(Z_1 >= z, dots, Z_n >= z) \
    &= Pr(X_1 >= z - t_1, dots, X_n >= z - t_n) \
    &= Pr(X_1 >= z - t_1)Pr(X_2 >= z - t_2) dots Pr(X_n >= z - t_n) \
    &= product_i^k e^(- 1 / mu_i (z - t_i)) gap (t_k <= z < t_(k + 1))
  $

- $
    expect[Z]
    &= integral_0^infinity Pr(Z >= z) dif z \
    &= integral_0^t_1 exp(- 1 / mu_1 (z - t_1)) dif z \
    &gap+ integral_(t_1)^(t_2) exp(- 1 / mu_1 (z - t_1) - 1 / mu_2 (z - t_2)) \
    &gap+ dots \
    &gap+ integral_(t_n)^(infinity) exp(- sum _(i = 1) ^n 1 / mu_i (z - t_i)) \
    &= sum_(i = 0)^n exp(sum _(j = 1) ^(i + 1) t_j / mu_j) / c_i (e^(- c_i t_i) - e^(- c_i t_(i + 1)))
  $

  - When $c_i = sum_(j = 1)^n 1 / mu_j$

  - Although the equation is complicated, we can calculate its value if $mu_i$ and $t_i$ are all given

- Since the time you have to wait for the bus is exponentially distributed, it does not matter when the last bus arrived

- When the bus arrives, compare $t_i$ of the arrived bus to $expect[Z]$

  - If $t_i < expect[Z]$, take the bus

  - Otherwise, don't take the bus

\

== Excercise 9.2.
Let X be a standard normal random variable. Prove that $expect[X^n] = 0$ for odd $n ≥ 1$, and $expect[X^n] ≥ 1$ for even $n ≥ 2$. (Hint: you can use integration by parts to derive an expression for $expect[X^n]$ in terms of $expect[X ^(n − 2)]$.)

=== Solution

- $
    expect[X^n]
    &= 1 / sqrt(2 pi) infintegral x^n e^(- x^2 \/ 2) dif x \
    &= lr(- 1 / sqrt(2 pi) x^(n - 1) e^(- x^2 \/ 2) mid(|))_(- infinity)^infinity
    + (n - 1) times 1 / sqrt(2 pi) integral x^(n - 2) dif x \
    &= (n - 1) expect[X^(n - 2)]
  $

  - For odd $n$:

    - $expect[X^n] = (n - 1) times (n - 3) dots times 2 times expect[X] = 0$

  - For even $n$:

    - $expect[X^n] = (n - 1) times (n - 3) dots times 3 times expect[X^2] > 1$

\

== Excercise 9.4
Let $rho_(X Y) = "Cov"(X, Y) / (sigma_X sigma_Y)$ be the correlation coefficient of $X$ and $Y$.

=== (a)
Prove that for any two random variables $X$ and $Y$ , $abs(rho_(X Y)) ≤ 1$.

==== Cauchy-schwarz Inequailty <cauchy-schwarz>

- For any two random variables $X$ and $Y$, $expect[X^2] expect[Y^2] >= (expect[X Y]) ^2$

- Proof:

  - $
      expect[(X + lambda Y)^2]
      &= expect[X^2 + 2 lambda X Y + lambda^2 Y^2] \
      &= expect[X^2] + 2 lambda expect[X Y] + lambda^2 expect[Y^2] \
      &= expect[Y^2] lambda^2 + 2 expect[X Y] lambda + expect[X^2]
    $

    - This is a quadratic function of $lambda$

  - Assume a quadratic equation (with respect to $lambda$): $expect[Y^2] lambda^2 + 2 expect[X Y] lambda + expect[X^2] = 0$

    - Since $forall lambda, expect[(X + lambda Y)^2] >= 0 gap (because (X + lambda Y)^2 >= 0)$

      - There can be at most 1 $lambda$ that satisfies the quadratic equation.

    - The discriminant of the quadratic equation: $
        Delta = expect[X Y] ^2 - expect[X^2] expect[Y^2] <= 0
      $

  - $therefore expect[X^2] expect[Y^2] >= expect[X Y]$

==== Solution

- $
    variance(X)variance(Y)
    &= expect[(X - expect[X])^2] expect[(Y - expect[Y])^2] \
    &>= (expect[(X - expect[X])(Y - expect[Y])])^2 gap
    (because #link(label("cauchy-schwarz"), "Cauchy-schwarz inequality")) \
    &= (covariance(X, Y))^2
  $

  - $ rho_(X Y)^2 = (covariance(X, Y))^2 / (variance(X)variance(Y)) <= 1 $

- $therefore abs(rho_(X Y)) <= 1$

=== (b)
Prove that if $X$ and $Y$ are independent then $rho_(X Y) = 0$

==== Solution

- $
    covariance(X, Y)
    &= expect[(X - expect[X])(Y - expect[Y])] \
    &= expect[X Y] - expect[expect[X] Y] - expect[X expect[Y]] + expect[expect[X] expect[Y]] \
    &= expect [X Y] - expect[X] expect[Y] - expect[X] expect[Y] + expect[X] expect[Y] \
    &= expect[X Y] - expect[X] expect[Y] \
    &= 0 gap (because X" and "Y" are independent")
  $

- $therefore rho_(X Y) = (covariance(X, Y)) / (sigma_X sigma_Y) = 0$

=== (c)
Give an example of two random variables $X$ and $Y$ that are not independent but $rho_(X Y) = 0$.

==== Solution

- Let:

  - $X$: A random variable such that
    - $
        Pr(X = 1) = Pr(X = 0) = Pr(X = -1) = 1 / 3
      $

  - $Y := X^2$

- $X$ and $Y$ are trivially dependent

  - $ Pr(X = 0, Y = 1) = 0 != Pr(X = 0) Pr(Y = 1) = 1 / 3 times 2 / 3 $

- $ expect[X] = 0, expect[Y] = 2 / 3 $

- $
    covariance(X, Y)
    = 1 / 3 times 1 times 1 / 3 + 1 / 3 times 0 times (- 2 / 3) + 1 / 3 times (-1) times 1 / 3 = 0
  $

  - $therefore rho_(X Y) = (covariance(X, Y)) / (sigma_X sigma_Y) = 0$

\

== Exercise 9.14.
Let $X$ be a standard normal random variable, and let $Y = X Z$, where $Z$ is a random variable independent of $X$ that takes on the value $1$ with probability $1/2$ and the value $−1$ with probability $1/2$.

=== (a)
Show that $Y$ is also a standard normal random variable.

- $
    Pr(Y <= y)
    &= Pr(Y <= y | Z = 1) Pr(Z = 1) + Pr(Y <= y | Z = -1) Pr(Z = -1) \
    &= 1 / 2 Pr(X <= y) + 1 / 2 Pr(-X <= y) \
    &= 1 / 2 Pr(X <= y) + 1 / 2 Pr(X >= - y) \
    &= Pr(X <= y) gap (because "Symmetry of standard normal") \
    &= Phi(y)
  $

- $therefore$ $Y$ is also a standard normal random variable

=== (b)
Explain why $X$ and $Y$ are not independent.

- $ f_X (x) = 1 / sqrt(2 pi) e^(- x^2 \/ 2) $

- $ f_Y (y) = 1 / sqrt(2 pi) e^(- y^2 \/ 2) $

- $
    f_(X Y) (x, y)
    &= f_(Y|X) (x, y) f_X (x) \
    &= cases(1 / 2 times 1 / sqrt(2 pi) e^(- x^2 \/ 2) gap &(x = y "or" x = -y), 0 gap &("otherwise"))
  $

- $f_(X Y) (x, y) != f_X (x) f_Y (y)$

- $therefore$ $X$ and $Y$ are not independent

=== (c)
Provide a reasoning that shows that $X$ and $Y$ are not jointly normal.

- The joint density function of $X$ and $Y$: $
    f_(X Y) (x, y) = cases(1 / 2 times 1 / sqrt(2 pi) e^(- x^2 \/ 2) gap &(x = y "or" x = -y), 0 gap &("otherwise"))
  $

  - This does not match the form of bivariate normal distribution

- $therefore$ The two variables are not jointly normal

=== (d)
Calculate the correlation coefficient of X and Y.

- $
    covariance(X, Y)
    &= expect[X Y] gap (because expect[X] = 0, expect[Y] = 0) \
    &= expect[X^2 Z] \
    &= expect[X^2] expect[Z] gap (because X "and" Z "are independent") \
    &= 0
  $

- $ therefore rho_(X Y) = (covariance(X, Y)) / (sigma_X sigma_Y) = 0 $