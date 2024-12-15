#import "../../templates/template-assignment.typ": *
#import "../utils/probability_table.typ": *

#show: template-assignment.with(
  title: "Assignment 2",
  student_id: "2023-12675",
  author: "박지호",
)

== 4.1

=== 4.1-(1)

#[
  #set align(center)
  #probability-table(
    [$overline(X)$],
    ([$ 9 / 5 $], [$ 11 / 5 $], [$ 12 / 5 $], [$ 13 / 5 $]), // Column labels
    ([$ 1/5 $], [$ 2/5 $], [$ 1/5 $], [$ 1/5 $])
  )
]

- $E(overline(X)) = 56 / 25$

=== 4.1-(2)

#[
  #set align(center)
  #probability-table(
    [$S^2$],
    ([$ 11 / 12 $], [$ 19 / 12 $], [$ 8 / 3 $], [$ 35 / 12 $]), // Column labels
    ([$ 1/5 $], [$ 1/5 $], [$ 1/5 $], [$ 2/5 $])
  )
]

- $italic("Var")(S^2) = 505 / 576$

== 4.2

=== 4.2-(1)

- 1회 시행 시 앞면 2번, 뒷면 1번 나올 확률: $ mat(3 ; 1) times 2/3 times 2/3 times 1/3 = 4/9$

- $ X #h(0.5em) ~ #h(0.5em) B(25, #h(0.5em) 4/9) $

- $ E(X) = 25 times 4 / 9 = 100/9, #h(0.5em) sigma(X) = sqrt(25 times 4 / 9 times 5 / 9) = (10 sqrt(5)) / 9 $

=== 4.2-(2)

- $X$는 $n = 25$로 $n$이 충분히 크고, $p = 4/9$로 대칭적인 확률을 가진 이항분포를 따르기 때문에 다음과 같이 근사할 수 있다. $ Z = (X - E(X)) / sigma(X) #h(0.5em) ~ #h(0.5em) N(0, 1) $

- $ P(X > 15) = P(Z > (7 sqrt(5)) / 10) = 0.05876 $

=== 4.2-(3)

- $ 
P(Z <= 1.64) = 0.95 \ 
k < 1.64 times (10 sqrt(5)) / 9 + 100 / 9 = 15. 18
$

- $k = 15$

== 5.1

=== 5.1-(1)

- 모표준편차 $sigma = 5$, 표본 크기 $n = 24$에 대해

  - $X_i #h(0.5em) ~ #h(0.5em) N(mu, sigma^2) $ 

  - $overline(X) = (sum _(i = 1) ^n X_i) / n$이라고 하면, $overline(X) #h(0.5em) ~ #h(0.5em) N(mu, (sigma ^2) / n)$

  - $alpha = 0.05$

- $ overline(x) - z_(alpha / 2) times sigma / sqrt(n) <= mu  <= overline(x) + z_(alpha / 2) times sigma / sqrt(n) $

- $346.30 <= mu <= 350.30$

=== 5.1-(2)

- 모평균 $mu$, 모표준편차 $sigma=5$, 표본 크기 $n = 24$에 대해

  - $X_i #h(0.5em) ~ #h(0.5em) N(mu, sigma^2) $

  - $overline(X) = (sum _(i = 1) ^n X_i) / n$이라고 하면, $overline(X) #h(0.5em) ~ #h(0.5em) N(mu, (sigma ^2) / n)$

- 가설 설정

  - 귀무가설 $upright("H")_0: mu >= mu_0 = 350$

  - 대립가설 $upright("H")_1: mu < mu_0 = 350$

  - 유의수준 $alpha = 0.05$

- 귀무가설 하에서의 검정통계량 $Z = (overline(X) - mu_0) / (sigma / sqrt(n)) #h(0.5em) ~ #h(0.5em) N(0, 1)$

  - $z = -1.666$

  - $P = P(Z <= z | upright("H")_0) = 0.048$

- 유의수준 $alpha = 0.05$에서 귀무가설이 기각되며, 유의수준 $alpha = 0.05$에서 350ml보다 적은 탄산수가 병에 담겨진다고 말할 수 있다.

=== 5.1-(3)

- 모평균 $mu = 348$, 모표준편차 $sigma = 5$, 표본 크기 $n = 24$에 대해

  - $X_i #h(0.5em) ~ #h(0.5em) N(mu, sigma)$

  - $overline(X) = (sum _(i = 1) ^n X_i) / n$이라고 하면, $overline(X) #h(0.5em) ~ #h(0.5em) N(mu, sigma / sqrt(n))$

  - $Z = (overline(X) - mu)/(sigma / sqrt(n)) #h(0.5em) ~ #h(0.5em) N(0, 1)$

- 유의수준 $alpha = 0.05$에서 귀무가설을 기각할 수 없으려면 

  - 표본평균 $overline(X)$가 $mu_0 - z_(alpha) times sigma / sqrt(n) = 348.32$ 이상이어야 함

- $P(overline(X) >= 348.32) = P(Z >= 0.3135) = 0.377$

=== 5.1-(4)

- $n = 24$일 때 검정력 $0.6253$

- $n = 30$일 때 검정력 $0.7091$

- $n = 40$일 때 검정력 $0.8132$

- $n = 50$일 때 검정력 $0.8827$

- $n = 60$일 때 검정력 $0.9276$

- $n = 70$일 때 결정력 $0.9561$

- $n = 69$일 때 결정력 $0.9538$

- $n = 68$일 때 결정력 $0.9514$

- $n = 67$일 때 결정력 $0.9489$

- 최소 68병의 탄산수를 조사하여야 한다

== 5.2

=== 5.2-(1)

- A주머니에서 공을 두 개 꺼냈을 때 두 공이 모두 파란색일 확률

- $ 1 / mat(9;2) = 1 / 36 $

=== 5.2-(2)

- B주머니에서 공을 두 개 꺼냈을 때 두 공이 모두 파란색이 아닐 확률

- $ 1 - mat(5;2) / mat(9;2) = 13 / 18 $