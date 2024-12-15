#import "../../templates/template-assignment.typ": *
#import "../../utils/utils.typ": *
#import "../utils.typ": *


#show: template-assignment.with(
  title: "Assignment 6",
  student_id: "2023-12675",
  author: "박지호",
)

== 6.2

=== (a)

- Let:

  - $S$: A sample space consisting of all possible colorings of the edges of $K_n$

  - $X$: A random variable on $S$ that denotes a number of monochromatic copies of $K_4$

  - $C_i$: The $i$-th 4-vertex clique of $K_n$

  - $ A_i = cases(1 #h(0.5em) &("if "C_i" is monochromatic"), 0 #h(0.5em) &("otherwise")) $

    - $ X = sum_(i = 1)^(binom(n, 4)) A_i $

- If we color each edge of the $K_n$ independently, with each edge taking each of the two colors with probability $1 / 2$, we obtain a random coloring chosen uniformly from $S$

  - $ expect[A_i] = 2 / 2^binom(4, 2) = 1 / 32 $

  - $ expect[X] = sum_(i = 1)^(binom(n, 4)) expect[A_i] = binom(n, 4) 2^(-5) $

  - $ therefore Pr(X <= binom(n, 4) 2^(-5)) > 0 $

- Since there is a probability strictly greater than zero to select a coloring for $K_n$ with at most $binom(n, 4) 2^(-5)$ monochromatic $K_4$,

  - There exists a coloring of the edges of the complete graph $K_n$ by two colors so that the total number of monochromatic copies of $K_4$ is at most $binom(n, 4) 2^(−5)$

=== (b)

- Color each edge of the $K_n$ independently, with each edge taking each of the two colors with probability $1 / 2$

  - From (a), there is a nonzero chance that this randomized algorithm results in a coloring with at most $binom(n, 4) 2^(−5)$ monochromatic copies of $K_4$

  - This algorithm requires $binom(n, 2) = O(n^2)$ time to run ($binom(n, 4) binom(4, 2) = O(n^4)$ for checking if the result is correct)

- Success probability:

  - $
      binom(n, 4) 2^(-5)
      &= expect[X] \
      &= sum_(i <= binom(n, 4) 2^(-5) - 1) i Pr(X = i) + sum_(i >= binom(n, 4) 2^(-5)) i Pr(X = i) \
      &<= sum_(i <= binom(n, 4) 2^(-5) - 1) (binom(n, 4) 2^(-5) - 1) Pr(X = i) + sum_(i >= binom(n, 4) 2^(-5)) binom(n, 4) Pr(X = i) \
      &= (1 - p) (binom(n, 4) 2^(-5) - 1) + p binom(n, 4)
    $

    - $therefore p >= O(n^(-4))$

- $ "Expected runtime" = "Single runtime" times 1 / "Success probability" = O(n^8) $

=== (c)

- Let:

  - $e_1, dots, e_(binom(n, 2))$: The edges of $K_n$

  - $C_i_1, dots, C_i_(binom(n - 2, 2))$: The 4-vertex clique of $K_n$ containing $e_j$

    - There are $binom(n - 2, 2)$ because 2 additional vertices must be selected along with two that is connected by $e_j$

  - $x_j$: The coloring of $e_j$

  - The colors used: Red & Blue

==== The algorithm

- For $j = 1$ to $binom(n, 2)$

  - $w <- 0$

  - For $k = 1$ to $binom(n - 2, 2)$

    - If edges in $C_i_k$ are only colored in red so far, $w <- w - expect[A_i_k | x_1, dots, x_(j - 1)]$

    - If edges in $C_i_k$ are only colored in blue so far, $w <- w + expect[A_i_k | x_1, dots, x_(j - 1)]$

    - Otherwise (If edges in $C_i_k$ are not colored yet, or are colored using both red and blue), $w <- w$

  - If $w >= 0$, color $e_j$ red, oherwise ($w < 0$), color $e_j$ blue

- The algorithm takes $binom(n, 2) times binom(n - 2, 2) times 6 = O(n^4)$ time

==== Justification

- Proposition: $expect[X | x_1, dots, x_j] <= expect[X | x_1, dots, x_(j - 1)]$

  - Every clique in ${C_1, dots, C_binom(n, 4)} - {C_i_1, dots, C_i_binom(n - 2, 2)}$ (Cliques that doesn't contain $e_j$) is unaffected by coloring of $e_j$.

  - For clique $C_i_k$ in ${C_i_1, dots, C_i_binom(n - 2, 2)}$

    - If edges in $C_i_k$ not colored yet:

      - $ expect[A_i_k | x_1, dots, x_(j - 1)] = 2 / 64 = 1 / 32 $

      - $ expect[A_i_k | x_1, dots, x_j] = 1 / 32 #h(0.5em) ("Regardless of the color of "e_j) $

      - $ expect[A_i_k | x_1, dots, x_j] - expect[A_i_k | x_1, dots, x_(j - 1)] = 0 $

    - If edges in $C_i_k$ are previously colored using both red and blue:

      - $ expect[A_i_k | x_1, dots, x_(j - 1)] = 0 $

      - $ expect[A_i_k | x_1, dots, x_j] = 0 #h(0.5em) ("Regardless of the color of "e_j) $

      - $ expect[A_i_k | x_1, dots, x_j] - expect[A_i_k | x_1, dots, x_(j - 1)] = 0 $

    - If edges in $C_i_k$ are previously colored only in red:

      - Let: $t$ the number of edges in $C_i_k$ not already colored

      - $ expect[A_i_k | x_1, dots, x_(j - 1)] = 1 / 2^t $

        - $because$ $t$ more edges should be colored in red in order for $A_i_k$ to be 1

      - $
          expect[A_i_k | x_1, dots, x_j]
          = cases(
          1 / 2^(t - 1) #h(0.5em) &("If we color "e_j" in red"),
          0 #h(0.5em) &("If we color "e_j" in blue")
        )
        $

        - $because$ $t - 1$ more edges should be colored in red in order for $A_i_k$ to be 1

      - $
          expect[A_i_k | x_1, dots, x_j] - expect[A_i_k | x_1, dots, x_(j - 1)]
          = cases(
          expect[A_i_k | x_1, dots, x_(j - 1)] #h(0.5em) &("If we color "e_j" in red"),
          - expect[A_i_k | x_1, dots, x_(j - 1)] #h(0.5em) &("If we color "e_j" in blue")
        )
        $

    - If edges in $C_i_k$ are previously colored only in blue:

      - In the same way as previous case, $
        expect[A_i_k | x_1, dots, x_j] - expect[A_i_k | x_1, dots, x_(j - 1)]
        = cases(
          -expect[A_i_k | x_1, dots, x_(j - 1)] #h(0.5em) &("If we color "e_j" in red"),
          expect[A_i_k | x_1, dots, x_(j - 1)] #h(0.5em) &("If we color "e_j" in blue")
        )
      $

  - $
      therefore expect[A_i_k | x_1, dots, x_j] - expect[A_i_k | x_1, dots, x_(j - 1)]
      = cases(
      -w #h(0.5em) &("If we color "e_j" in red"),
      w #h(0.5em) &("If we color "e_j" in blue")
    )
    $

    - Since the algorithm selects red if $w >= 0$ and blue if $w < 0$, this difference is always less than or equal to $0$

- $expect[X | x_1, dots, x_n] <= expect[X] = binom(n, 4) 2^(−5)$

  - The total number of monochromatic copies of $K_4$ in the result is at most $binom(n, 4) 2^(−5)$.

== 6.6

=== Existence

- Let:

  - $S$: The sample space consisting of every possible $k$-cut of graph $G$

  - $C(A_1, dots, A_k)$: A random variable on $S$ which denotes the value of $k$-cut corresponding to sets $A_1, dots, A_k$

  - $e_1, dots, e_m$: The edges of $G$

  - $
      X_i = cases(
      1 #h(0.5em) &("if "e_i "connects different sets"),
      0 #h(0.5em) &("otherwise")
    )
    $

    - $ C(A_1, dots, A_k) = sum_(i = 1)^m X_i $

- If we assign each vertex to $A_1, dots, A_k$ with equal probabilities $1 / k$, we get obtain a $k$-cut of $G$ chosen uniformly from $S$

  - $ expect[X_i] = 1 - 1 / k = (k - 1) / k $

    - $because Pr(X_i = 0) = 1 / k$ (Both vertices must be assigned in the same set)

  - $ expect[C(A_1, dots, A_k)] = sum_(i = 1)^m expect[X_i] = m(k -1) / k $

  - $Pr(C(A_1, dots, A_k) >= m(k -1)/k) > 0$

- Since there is a probability strictly greater than zero to select a $k$-cut with value higher than $m(k - 1) / k$

  - There exists a $k$-cut of $G$ with a value higher than $m(k - 1) / k$

=== Deterministic algorithm

- Let:

  - $v_1, dots, v_n$: The vertices of $G$

  - $x_j$: The set $v_j$ is assigned to

==== The algorithm

- For $j = 1$ to $n$

  - Assign $v_j$ to the set with the least vertices connected to $v_j$

==== Justification

- Let:

  - $c_l$ be the number of vertices in $A_l$ connected to $v_j$

- Without loss of generality, $v_j$ is assigned to $A_1$

- Proposition: $expect[C(A_1, dots, A_k) | x_1, dots, x_j] = expect[C(A_1, dots, A_k) | x_1, dots, x_(j - 1)]$

  - For an edge $e_i$ in ${e_1, dots, e_m}$

    - If $e_i$ connects two vertex from $v_1, dots, v_(j - 1)$

      - $expect[X_i | x_1, dots, x_j] - expect[X_i | x_1, dots, x_(j - 1)] = 0$ (Already determined)

    - If $e_i$ includes $v_(j + 1), dots, v_m$

      - $expect[X_i | x_1, dots, x_j] - expect[X_i | x_1, dots, x_(j - 1)] = (k - 1) / k - (k - 1) / k = 0$

    - If $e_i$ connects a vertex from $v_1, dots, v_(j - 1)$ to $v_j$

      - $
          expect[X_i | x_1, dots, x_j] - expect[X_i | x_1, dots, x_(j - 1)] \
          = cases(
          0 - (k - 1) / k = - (k - 1) / k #h(0.5em) &("If "v_j" is assigned to the same set as the other vertex"),
          1 - (k - 1) / k = 1 / k #h(0.5em) &("Otherwise")
        )
        $

  - $
      &expect[C(A_1, dots, A_k) | x_1, dots, x_j] - expect[C(A_1, dots, A_k) | x_1, dots, x_(j - 1)] \
      &= sum_(i = 1)^m (expect[X_l | x_1, dots, x_j] - expect[X_l | x_1, dots, x_(j - 1)]) \
      &= sum_(v_j in e_i) (expect[X_i | x_1, dots, x_j] - expect[X_i | x_1, dots, x_(j - 1)]) \
      &= - (k - 1) / k times c_1 + sum_(l = 2)^k 1 / k times c_l \
      &= sum_(l = 1)^k (1 / k times (c_l - c_1))
    $

  - Since we assign $v_j$ to the set with least vertices connected to $v_j$

    - $forall l, c_l - c_1 > 0$

    - This difference is always greater than equal to 0

- $expect[X | x_1, dots, x_n] >= expect[X] m(k - 1) / k$

  - The value of the resulting cut is greater than or equal to $m(k - 1)/k$

== 6.10

=== (a)

- The set of subsets of ${1, 2, dots, n}$ with $floor(n / 2)$ elements

  - Each set cannot contain other set because they have equal number of elements.

=== (b)

- Let:

  - $P_1, P_2, dots, P_N$: An arbitrary ordering of every possible permutation of ${1, dots, n}$

    - $N = n!$

  - $
      X_(i, k) := cases(
      1 #space &("If the first "k" numbers in "P_i" yields a set in "cal(F)),
      0 #space &("Otherwise")
    )
    $

    - $ X_i := sum_(k = 0)^n X_(i, k) $

    - $ X := sum_(i = 1)^N X_i = sum_(i = 1)^N sum_(k = 0)^n X_(i, k) $

- For an antichain $cal(F)$

  - $X_i <= 1$

    - $because$ $cal(F)$ cannot contain two sets formed by taking the first $k$ elements from $C_i$, as one is always subset of another.

    - $X = sum_(i = 1)^N X_i <= n!$

  - For every set $A in cal(F)$, if $abs(A) = k$

    - There are $k!(n - k)!$ permutations from which $A$ can be formed by taking first $k$ numbers

      - $because$ $k!$ ways to order the $k$ elements in $A$ in front, and $(n - k)!$ ways to order the remaining $n - k$ elements in the back

  - $
      therefore X &= sum_(i = 0)^N sum_(k = 0)^n X_(i, k) \
      &= sum_(A in cal(F)) abs(A)!(n - abs(A))! \
      &= sum_(k = 0)^n sum_#center-align-block[
      $A in cal(F)$\
      $abs(A) = k$
    ] |A| (n - |A|)! \
      &= sum_(k = 0)^n (k! (n - k)! dot sum_#center-align-block[
      $A in cal(F)$\
      $abs(A) = k$
    ] 1) \
      &= sum_(k = 0)^n f_k dot k!(n - k)!
    $

    - Dividing both sides by $n!$, we get $
      sum_(k = 0) ^n f_k dot (k!(n - k)!) / n! &= sum_(k = 0) ^n f_k / binom(n, k) = X / n! <= 1
    $

- $therefore$ For an antichain $cal(F)$, $ sum_(k = 0) ^n f_k / binom(n, k) <= 1 $

=== (c)

- $
    abs(cal(F)) = sum_(k = 0)^n f_k <= sum_(k = 0)^n f_k times binom(n, floor(n / 2)) / binom(n, k) = binom(n, floor(n / 2)) times sum_(k = 0)^n f_k / binom(n, k) <= binom(n, floor(n / 2))
  $

  - $
      because forall k; 0 <= k <= n, binom(n, k) <= binom(n, floor(n / 2)) <=> 1 <= binom(n, floor(n / 2)) / binom(n, k)
    $

== 6.13

#let threshold = $n^(- 2 / (k - 1))$

- Threshold function: #threshold

  - If $p = f(n)$ and $f(n) = o(threshold)$

    - For any $epsilon$ and for sufficiently large $n$,

    - The probability that a random graph chosen from $G_(n, p)$ has a clique with $k$ or more vertices is less than $epsilon$

  - If $p = f(n)$ and $f(n) = omega(threshold)$

    - For any $epsilon$ and for sufficiently large $n$,

    - The probability that a random graph chosen from $G_(n, p)$ doesn't have a clique with $k$ or more vertices is less than $epsilon$

- Let:

  - $C_1, dots, C_N$: An arbitrary ordering of subset of $k$ vertices from $G$

    - $ N = binom(n, k) $

  - $
      X_i := cases(
      1 space &("If "C_i" is a "k"-clique"),
      0 space &("Otherwise")
    )
    $

    - $ X := sum_(i = 1)^N X_i $

- $expect[X]$

  - $ expect[X_i] = p^binom(k, 2) $

  - $ expect[X] &= sum_(i = 1)^N expect[X_i] = binom(n, k) p^binom(k, 2) <= Theta(n^k p^binom(k, 2)) $

- If $p = f(n)$ and $f(n) = o(threshold)$

  - $ lim_(n -> infinity) (p n^(2 / (k - 1)))^binom(k, 2) = 0 $

    - $therefore expect[X] = o(1)$

  - Sicne $X$ can only have nonnegative integer value,

    - $ Pr(X >= 1) <= expect[X] = o(1) $

  - $therefore$ The probability that a random graph $G$ chosen from $G_(n, p)$ has a clique with $k$ or more vertices is less than $epsilon$ for a sufficiently large $n$

- If $p = f(n)$ and $f(n) = omega(threshold)$

  - $ Pr(X > 0) >= sum_(i = 1)^N Pr(X_i = 1) / expect[X | X_i = 1] $

  - When $k = 5$:


    - $ Pr(X_i = 1) = p^10 $

    - $
        Pr(X_j = 1 | X_i = 1) = cases(
        1 space &(C_i" and "C_j" share 5 vertices"(i = j)) space &(1" case"),
        p^4 space &(C_i" and "C_j" share 4 vertices") space &(binom(5, 4)binom(n - 5, 1)" cases"),
        p^7 space &(C_i" and "C_j" share 3 vertices") space &(binom(5, 3)binom(n - 5, 2)" cases"),
        p^9 space &(C_i" and "C_j" share 2 vertices") space &(binom(5, 2)binom(n - 5, 3)" cases"),
        p^10 space &(C_i" and "C_j" share 1 vertex") space &(binom(5, 1)binom(n - 5, 4)" cases"),
        p^10 space &(C_i" and "C_j" share no vertex") space &(binom(5, 0)binom(n - 5, 5)" cases")
      )
      $

      - $
          expect[X | X_i = 1] &= sum_(j = 1)^N expect[X_j | X_i = 1] \
          &= binom(5, 0)binom(n - 5, 5) p^10 + binom(5, 1)binom(n - 5, 4) p^10 + binom(5, 2)binom(n - 5, 3) p^9 + binom(5, 3)binom(n - 5, 2) p^7 \
          &+ binom(5, 4)binom(n - 5, 1) p^4 + 1
        $

    - If $p = omega(threshold) = omega(n^(-1/2))$, the term $binom(n - 5, 5) p^10$ dominates, so $
      expect[X] ~ binom(n - 5, 5) p^10
    $

    - $ Pr(X > 0) >= sum_(i = 1)^N Pr(X_i = 1) / expect[X | X_i = 1] ~ binom(n, 5) / binom(n - 5, 5) $

      - As $n$ approaches $infinity$, this value reaches 1

    - The probability that a random graph $G$ chosen from $G_(n, p)$ doesn't have a clique with $5$ or more vertices is less than $epsilon$ for a sufficiently large $n$

== 6.15

- Let:

  - $C_1, C_2, dots, C_N$: An arbitrary ordering of subset of $3$ vertices from $G$

    - $N = binom(n, 3)$

  - $
      X_i := cases(
      1 space &("If "C_i" is a "3"-clique"),
      0 space &("Otherwise"),
    )
    $

    - $ X = sum_(i = 1)^N X_i $

=== $ Pr(X >= 1) >= 1 / 6 $

- $
    Pr(X >= 1)
    = Pr(union.big_(i = 1)^N (X_i = 1)) <= sum_(i = 1)^N Pr(X_i = 1) = binom(n, 3) p^3 <= 1 / 6
  $

=== $ lim_(n -> infinity) Pr(X >= 1) <= 1 / 7 $

- $
    Pr(X >= 1)
    = Pr(X > 0)
    >= sum_(i = 1)^N Pr(X _i = 1) / expect[X | X_i = 1]
  $

- $Pr(X _i = 1) = p^3$

- $
    Pr(X_j = 1 | X_i = 1) = cases(
    1 space &(C_i" and "C_j" share 3 vertices"(i = j)) space &(1" case"),
    p^2 space &(C_i" and "C_j" share 2 vertices") space &(binom(3, 2)binom(n - 3, 1)" cases"),
    p^3 space &(C_i" and "C_j" share 1 vertex") space &(binom(3, 1)binom(n - 3, 2)" cases"),
    p^3 space &(C_i" and "C_j" share no vertex") space &(binom(3, 0)binom(n - 3, 3)" cases")
  )
  $

  - $
      expect[X | X_i = 1] &= sum_(i = 1)^N expect[X_j | X_i = 1] \
      &= binom(3, 0)binom(n - 3, 3) p^3 + binom(3, 1)binom(n - 3, 2) p^3 + binom(3, 2)binom(n - 3, 1) p^2 + 1
    $

- $
    Pr(X >= 1) &>= sum_(i = 1)^N Pr(X _i = 1) / expect[X | X_i = 1] \
    &= (binom(n, 3) p^3) / (binom(3, 0)binom(n - 3, 3) p^3 + binom(3, 1)binom(n - 3, 2) p^3 + binom(3, 2)binom(n - 3, 1) p^2 + 1) \
    &= (binom(n, 3) (1 / n)^3) / (binom(3, 0)binom(n - 3, 3) (1 / n)^3 + binom(3, 1)binom(n - 3, 2) (1 / n)^3 + binom(3, 2)binom(n - 3, 1) (1 / n)^2 + 1) \
    &= (1 / 6 + O(1 / n)) / (7 / 6 + O(1 / n))
  $

  - $ therefore lim_(n -> infinity) Pr(X >= 1) >= 1 / 7 $

== 6.17

- Let:

  - $S$: A sample space consisting of all possible colorings of the edges of $K_n$

  - $C_1, dots, C_N$: An arbitrary ordering of $k$-cliques from $K_n$

    - $N = binom(n, k)$

  - $E_i$: The event that $C_i$ is colored monochromatic

- If we color each edge of the $K_n$ independently, with each edge taking each of the two colors with probability $1 / 2$, we obtain a random coloring chosen uniformly from $S$

  - $ Pr(E_i) = 2 dot (1 / 2)^binom(k, 2) $

  - In the dependency graph for events $E_1, dots, E_N$:

    - $
        deg(i)
        <= binom(k, 2) binom(n - 2, k - 2)
        <= binom(k, 2) binom(n, k - 2)
      $

      - $E_i$ is only dependent to $E_j$ if $C_i$ and $C_j$ shares edges (Shares more than two vertices)

      - Choose two vertices from $C_i$, and other $k - 2$ from the remaining $n - 2$ vertices

        - Some graphs will be counted multiple times, but the product is still greater than deg(i)

  - $
      4 times max_i deg(i) times max_j Pr(E_j)
      <= 4 binom(k, 2) binom(n, k - 2) 2^(1 - binom(k, 2))
      <= 1
    $

    - $ therefore Pr(sect.big _(i = 1) ^N overline(E_i)) > 0 space ("Lovász local lemma") $

- Since there is a probability strictly greater than zero to select a coloring for $K_n$ such that there is no monochromatic $K_k$

  - It is possible to color edges of $K_n$ with two colors so that it has no monochromatic $K_k$ subgraph