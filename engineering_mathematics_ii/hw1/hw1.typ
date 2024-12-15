#import "../../templates/template-assignment.typ": *

#show: template-assignment.with(
  title: "Assignment 1",
  student_id: "2023-12675",
  author: "박지호",
)

== Exercise 1.4

- Let $"A"$ and $"B"$ the name of the contestants

- Without loss of generallity, assume $"A"$ wins the match

- In order $"B"$ to have won $k$ games when the match is over, a total of $n + k$ games must have been played

  - Within the first $n + k - 1$ games, $"A"$ must have won $n - 1$ games, and $"B"$ must have won $k$ games

  - Also, $"A"$ must have won the final game

  - The probability of this happening is $mat(n + k - 1; k) times (1 / 2)^(n + k)$

- We need to double this probability in order to account for cases that $"B"$ wins

- The answer: $mat(n + k - 1;k) times (1 / 2) ^ (n + k - 1)$

== Exercise 1.6

- Let $a_(m, k)$ be the probability that there are $k$ white balls in the bin once there are $m$ total balls in the bin.

  - $forall m, a_(m, 0) = a_(m, m) = 0$, $a_(2, 1) = 1$

  - $forall k "such that" 1 <= k, a_(m, k) = a_(m - 1, k) times (m - 1 - k) / (m - 1) + a_(m - 1, k -1) times (k - 1) / (m - 1)$

- Proposition: $forall k "such that" 1 <= k <= m - 1, a_(m, k) = 1 / (m - 1)$

  - Proposition holds for $m = 2$

    - $a_(2, 1) = 1 / (2 - 1)$

  - If the proposition holds for $m - 1$

    - $forall k & "such that" 2 <= k <= m - 2$

      - $
          a_(m, k)
          &= a_(m - 1, k) times (m - 1 - k) / (m - 1) + a_(m - 1, k -1) times (k - 1) / (m - 1) \
          &= 1 / (m - 2) times (m - 1 - k) / (m - 1) + 1 / (m - 2) times (k - 1) / (m - 1) \
          &= 1 / (m - 2) times (m - 2) / (m - 1) = 1 / (m - 1)
        $

    - #block($
        a_(m, 1)
        &= a_(m - 1, 1) times (m - 2) / (m - 1) + a_(m - 1, 0) times 0 / (m - 1) \
        &= 1 / (m - 2) times (m - 2) / (m - 1) = 1 / (m - 1)
      $)

    - $
        a_(m, m -1)
        &= a_(m - 1, m - 1) times 0 / (m - 1) + a_(m - 1, m - 2) times (m - 2) / (m - 1) \
        &= 1 / (m - 2) times (m - 2) / (m - 1) = 1 / (m - 1)
      $

    - The proposition holds for $m$

  - By mathematical induction, the proposition holds for all $m$

- $forall k "such that" 1 <= k <= n - 1, a_(n, k) = 1 / (n - 1)$

- Once there are $n$ total balls in the bin, the number of white balls is equally likely to be any number between $1$ and $n - 1$

== Exercise 1.8

- Let the event where the chosen number is divisible by $k$ be $E_k$

- $
    Pr( E_4 union E_6 union E_9 )
&= Pr(E_4) + Pr(E_6) + Pr(E_9) - Pr(E_4 sect E_6) - Pr(E_4 sect E_9) \
&#h(2em) - Pr (E_6 sect E_9) + Pr(E_4 sect E_6 sect E_9) \
&= Pr(E_4) + Pr(E_6) + Pr(E_9) - Pr(E_12) - Pr(E_36) - Pr (E_18) \
&#h(2em) + Pr(E_36) \
&= Pr(E_4) + Pr(E_6) + Pr(E_9) - Pr(E_12) - Pr (E_18) \
&= 250000 / 1000000 + 166666 / 1000000 + 111111 / 1000000 - 83333 / 1000000 - 55555 / 1000000 \
&= 388889 / 1000000
  $

== Exercise 1.15

- After rolling nine of the ten dice, let $x$ be the remainder when dividing the sum up to that point by $6$

- In order for the sum of all ten dice to be divisible by $6$, the last dice should be $6 - x$

  - The probability of this is $1 / 6$, regardless of the value of $x$

- The answer: $1 / 6$

== Exercise 1.18

=== Assumptions about the Evil Adversary

- For $x in {0, dots, n - 1}$, let $G(x)$ be the value in the lookup table that corresponds to $x$, after the Evil Adversary changed the values in the lookup table.

- We will assume that if the Evil Adversary changed the value of corresponding to $x$

  - $G(x) != F(x)$ (The Evil Adversary did change the value to a different value from original)

    - In other words, exactly $1/5$ of the values are different from original, $Pr((G(x) != F(x))) = 4/5$

  - $G(x) in {0, dots, m - 1}$ (The Evil Adversary made the value believable)

=== Randomized Algorithm

- For a given input $z$

  - Pick a random integer $x$ from ${0, ..., n - 1}$

  - Let $y = z - x mod n$

- Output $(G(x) + G(y)) mod m$

=== Success Probability of the Algorithm

- If $G(x) = F(x)$ and $G(y) = F(y)$, the algorithm outputs a correct value

  - The probability: $4/5 times 4/5 = 16 / 25$

- If $G(x) = F(x) and G(y) != F(y)$, or if $G(x) != F(x) and G(y) = F(y)$, then $(G(x) + G(y)) mod m != (F(x) + F(y)) mod m = F(z)$, and the algorithm outputs an incorrect value

- If $F(x)$ and $F(y)$ has both been changed,

  - There are $m - 1$ values, from ${0, dots, m - 1} - {F(y)}$, that $F(y)$ can be after being changed

  - No matter what value $G(x)$ has, there is exactly one value that $G(y)$ can have that makes the output value correct

    - This value cannot be $F(y)$, because then $G(x) = F(x)$

  - $therefore$ The probability: $1/5 times 1/5 times 1 / (m - 1)$

- The overall success probability: $16 / 25 + 1 / 25 times 1 / (m - 1)$

  - Let this value be $p_0$

=== Repeating the Algorithm Three Times

- Let $(a_1, a_2, a_3)$ be the three results of the algorithm, and let $a_0$ be the correct result of the algorithm

- The algorithm: if there is a value that happens twice or more, choose that value, otherwise, choose $a_1$

- No repeat value

  - In order for the overall algorithm to succeed,

    - The algorithm must have succeeded on the first try

    - Then failed twice resulting in different values

  - The probabilty: $p _0 (1 - p _0)^2 times (m - 2) / (m - 1)$

- Value repeated twice

  - In order for the overall algorithm to succeed,

    - The algorithm must have succeeded twice, and failed once, regardless of the order

  - The probability: $mat(3; 1) p_0^2 (1 - p_0)$

- Value repeated thrice

  - In order for the ovrall algorithm to succeed,

    - The algorithm must have succeeded all three times

  - The probability: $p_0 ^ 3$

- The overall probability: $
p _0 (1 - p _0)^2 times (m - 2) / (m - 1) + mat(3; 1) p_0^2 (1 - p_0) + p_0 ^ 3 \
= - p_0^3 + p_0 ^ 2 + p_0 - 1 / (m - 1) p_0 (1 - p_0)^2 \
= -639/(15625 (m - 1)) + 184/(15625 (m - 1)^2) + 1/(15625 (m - 1)^3) - 1/(15625 (m - 1)^4) + 12304/15625 \
$

  - Assuming $m -> infinity$, $12304 / 15625 approx 0.787$

== Exercise 1.23

- Let $C_1, dots, C_m$ be every distinct min-cut sets of the graph

- Let $E_i$ be the event where the randomized min-cut algorithm results in the cut set $C_i$

  - $Pr(E_i) >= 2 / (n (n - 1))$, according to the analysis of the algorithm

  - $E_i$ are mutually disjoint events, since the cut sets $C_i$ are distinct

- $m times 2 / (n (n - 1)) <= sum_(i = 1)^m Pr(E_i) <= 1$

  - $therefore m <= (n (n - 1)) / 2$, there can be at most $(n (n - 1)) / 2$ min-cut sets for any graph