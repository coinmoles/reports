#import "../../templates/template-assignment.typ": *
#import "../utils.typ": *

#show: template-assignment.with(
  title: "Assignment 2",
  student_id: "2023-12675",
  author: "박지호",
)

== Exercise 2.9

=== (a)

- $
    expect [max(X_1, X_2)]
    &= sum_(n = 1)^k n times Pr(max(X_1, X_2) = n) \
    &= sum_(n = 1)^k sum_(m = 1)^n Pr(max(X_1, X_2) = n)\
    &= sum_(m = 1)^k sum_(n = m)^k Pr(max(X_1, X_2) = n) \
    &= sum_(m = 1)^k Pr(max(X_1, X_2) >= m) \
    &= sum_(m = 1)^k (1 - Pr(max(X_1, X_2) < m)) \
    &= sum_(m = 1)^k lr((1 - (m - 1) ^2 / k ^2)) \
    &= k - 1 / k^2 times (k(k - 1)(2k - 1)) / 6 \
    &= (4k^2 + 3k - 1) / (6k)
  $

- $
    expect [min(X_1, X_2)]
    &= sum_(n = 1)^k n times Pr(min(X_1, X_2) = n) \
    &= sum_(n = 1)^k sum_(m = 1)^n Pr(min(X_1, X_2) = n)\
    &= sum_(m = 1)^k sum_(n = m)^k Pr(min(X_1, X_2) = n) \
    &= sum_(m = 1)^k Pr(min(X_1, X_2) >= m) \
    &= sum_(m = 1)^k (k + 1 - m)^2 / k^2 \
    &= 1 / k^2 times (k(k + 1)(2k + 1)) / 6 \
    &= (2k^2 + 3k + 1) / (6k)
  $

=== (b)
- From (a), $expect [max(X_1, X_2)]  + expect [min(X_1, X_2)] = k + 1$

- $expect[X_1] = expect[X_2]
    &= sum_(n = 1)^k n times Pr(X_1 = n) \
    &= sum_(n = 1)^k n times 1 / k \
    &= 1 / k times (k(k+1)) / 2 \
    &= (k + 1) / 2$

  - $expect[X_1] + expect[X_2] = k + 1$

- $therefore expect [max(X_1, X_2)] + expect [min(X_1, X_2)] = expect[X_1] + expect[X_2]$

=== (c)

- $max(X_1, X_2) + min(X_1, X_2) = X_1 + X_2$

- $
    &expect [max(X_1, X_2) + min(X_1, X_2)] = expect[X_1 + X_2] \
    &= expect [max(X_1, X_2)] + expect [min(X_1, X_2)] = expect[X_1] + expect[X_2]
  $

== 2.15

- Let $X$ be the number of total coin flips until the $k$-th head

- Let $X_i$ be the number of coin flips after the $i$-th head until the $i + 1$-th head. (Excluding the coin flip that results in $i$-th head, and including the coin flip that results in $i + 1$-th head)

  - $X_i$ all follows geometric distribution with parameter $p$, $expect [X_i] = 1 / p$

  - $X = sum_(i = 0)^(k - 1) X_i$

- $expect [X] = sum_(i = 0)^(k - 1) expect[X_i] = k / p$

- The expected number of coin flips until the $k$-th head is $k / p$

== 2.18

- After the $n$-th item,

- In order for the $k$-th item to be stored in memory

  - It should have replaced the item when it appeared $lr((1 / k))$

  - And it should not have been replaced afterwards $lr((product _(i = k + 1) ^n (i - 1) / i))$

- Therefore, the overall probability of $k$-th item being stored in memory is $
1/k times product _(i = k + 1) ^n (i - 1) / i
= 1/ k times k / (k + 1) times dots times (n - 1) / n
= 1/ n
$

  - There is an equal chance for each of $n$ items encountered to be the item stored in memory

- $therefore$ The desired property is achieved

== 2.22

=== BubbleSort mutation count

- Proposition: The number of mutations in the bubble sort is equal to the total number of inverted pair in the initial permutation

  - Proposition: A bubble sort mutation decreases the number of inverted pair by $1$

    - Let

      - The permutation before the mutation be $a_1, dots, a_k, a_(k + 1), dots, a_n$

      - And the permutation after the mutation be $b_1, dots, b_k, b_(k + 1), dots, b_n$

    - Let's say the mutation swapped $a_k$ and $a_(k + 1)$

      - $forall i != k, k + 1, b_i = a_i$, $b_k = a_(k + 1), b_(k + 1) = a_k$

    - After the permutation:

      - $(b_k, b_(k + 1))$ is not inverted, while $(a_k, a_(k + 1))$ was inverted

      - $forall i, j "such that" i, j != k, k + 1 and i < j$, the invertedness of the pair $(b_i, b_j)$ is equal to $(a_i, a_j)$

      - $forall i < k$, the invertedness of the pair $(b_i, b_k)$ is equal to $(a_i, a_(k + 1))$, and the invertedness of the pair $(b_i, b_(k + 1))$ is equal to $(b_i, b_k)$, leaving the total number of inverted pairs the same.

      - Likewise, $forall j > k + 1$, the invertedness of the pair $(b_k, b_j)$ is equal to $(a_(k + 1), a_j)$, and the invertedness of the pair $(b_(k + 1), b_j)$ is equal to $(a_k, a_j)$, leaving the total number of inverted pairs the same.

    - Therefore, the number of inverted pairs is descreased by exactly one after the mutation.

  - Since the result of the bubble sort is a sorted array with no inverted pairs,

    - The number of inverted pairs in the initial permutation is the number of mutations that happened in the process.

=== Expected Number of Inverted Pairs in Any Permutation

- We can compute the expected number of bubble sort mutation for any permutation by computing the expected number of inverted pair in any permutation

- For any permutation $a_1, dots, a_n$, there exists a permutation where the order of elements are completely reversed $b_1 = a_n, dots, b_n = a_1$

  - Exactly one of $(a_i, a_j)$ and $(b_i, b_j)$ is a inverted pair

  - Therefore, among the two permutations, there is exactly $mat(n;2) = (n(n - 1)) / 2$ inverted pairs

  - The average number of inverted pair among the two permutations is $(n (n - 1)) / 4$

- Since every permutation can be coupled like that, the average number, or the expected number of inverted pairs for every permutation is $(n (n - 1)) / 4$

- The expected number of bubble sort mutation for any permutation is also $(n (n - 1)) / 4$

== Exercise 2.27

- $
    expect [X] &= sum_(k = 1)^infinity k Pr(X = k) \
    &= sum_(k = 1)^infinity k 6 / pi^2 1 / k^2 \
    &= 6 / pi^2 sum_(k = 1)^infinity 1 / k \
  $

- The expected value of $X$ diverges

== Exercise 2.32

=== (a)

- For $i <= m$, trivially $Pr(E_i) = 0$

- For $i > m$, In order for $E_i$ to happened

  - The $i$-th candidate must be the best $lr((1 / n))$

  - We must not hire $m + 1$-th to $i - 1$-th candidate

    - The best candidate among the first $i - 1$ candidate should have been in the first $m$ candidate $lr((m / (i - 1)))$

- $
    Pr(E_i) = cases(
0 "if" i <=m,
1 / n times m / (i - 1) "otherwise"
) \
    Pr(E) = sum_(i = 1)^n Pr(E_i) = m / n sum_(i = m + 1)^n 1 / (i - 1)
  $

=== (b)

- $
    forall j "such that" i - 1 < j < i, 1 / j < 1 / (i - 1) < 1 / (j - 1) \
    sum_(i = m + 1)^n integral_(i - 1)^(i) 1 / j upright(d) j <
    sum_(i = m + 1)^n integral_(i - 1)^(i) 1 / (i - 1) upright(d) j <
    sum_(i = m + 1)^n integral_(i - 1)^(i) 1 / (j - 1) upright(d) j \
    integral_m^n 1 / j upright(d) j <
    sum_(i = m + 1)^n 1 / (i - 1) <
    integral_m^n 1 / (j - 1) upright(d) j \
    lr([ln |j|])_m^n <
    sum_(i = m + 1)^n 1 / (i - 1) <
    lr([ln |j - 1|])_m^n \
    ln n - ln m <
    sum_(i = m + 1)^n 1 / (i - 1) <
    ln (n - 1) - ln (m - 1) \
    m / n (ln n - ln m) < Pr(E) < m / n (ln (n - 1) - ln (m - 1))
  $

=== (c)

- $
    upright(d) / (upright(d) m) lr((m / n (ln n - ln m)))
    &= 1 / n (ln n - ln m) - m / n 1 / m \
    &= 1 / n (ln n - ln m - 1) = 0 \
    & <=> m = n / e
  $

- $m / n (ln n - ln m)$ is maximized when $m = n / e$

- For this $m$,

- $Pr(E) > m / n (ln n - ln m) = 1 / e$