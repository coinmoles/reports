#import "../../templates/template-assignment.typ": *
#import "../utils/probability_table.typ": *
#import "../utils/symbols.typ": *

#show: template-assignment.with(
  title: "Assignment 3",
  student_id: "2023-12675",
  author: "박지호",
)

== 6.1

=== 6.1.(1)

- Let $D_i := X_(1i) - X_(2i)$

- 분포 가정: $D_i ~^("iid") N(mu_1 - mu_2, sigma_D ^2)$

  - When $mu_1 := expect(X_(1i)), mu_2 := expect(X_(2i))$

- 가설:

  - 귀무가설 $hypothesis_0$: $mu_1 - mu_2 = 0$

  - 대립가설 $hypothesis_1$: $mu_1 - mu_2 > 0$

  - 유의수준 $alpha = 0.05$

- Let $T := (overline(D) - 0) / (S_D \/ sqrt(n))$

  - When $overline(D) := 1/n sum _(i = 1) ^(n) D_i, S_D := sqrt(1/(n - 1) sum_(i = 1)^n (D_i - overline(D))^2)$

- 귀무가설 $hypothesis_0$ 하에서

  - $T ~ t(n - 1)$

  - $n = 10, overline(d) = 29 / 10, s_D = sqrt(121/10)$

  - 관측값 $t_0 = (overline(d) - 0)/(s_D \/ sqrt(n)) = 29/11$

  - 유의확률 $Pr(T >= t_0) approx 0.01354 < alpha$

  - 유의수준 $alpha = 0.05$에서 귀무가설 기각

- $therefore$ 유의수준 5%에서 이 피임약이 혈압을 저하시킨다고 할 수 있다.

=== 6.1.(2)

- 분포 가정:

  - $X_(1i) ~^("iid") N(mu_1, sigma_1^2)$

  - $X_(2i) ~^("iid") N(mu_2, sigma_2^2)$

  - $X_(1i)$와 $X_(2i)$는 서로 독립

==== 등분산 검정 <variance>

- 가설:

  - 귀무가설 $hypothesis_0$: $sigma_1 ^2 = sigma_2 ^2$

  - 대립가설 $hypothesis_1$: $sigma_1 ^2 != sigma_2 ^2$

  - 유의수준 $alpha = 0.05$

- Let $F := (S_1^2 \/ sigma_1^2) / (S_2^2 \/ sigma_2^2)$

  - When $S_1:= sqrt(1/(n_1 - 1) sum_(i = 1)^n_1 (X_(1i) - overline(X_1))^2), S_2:= sqrt(1/(n_2 - 1) sum_(i = 1)^n_2 (X_(2i) - overline(X_2))^2)$

  - And $overline(X_1) := 1/n_1 sum _(i = 1)^n_1 X_(1i), overline(X_2) := 1/n_2 sum _(i = 1)^n_2 X_(2i)$

- 귀무가설 $hypothesis_0$ 하에서

  - $F ~ F(n_1 - 1, n_2 - 1)$

  - $n_1 = 10, n_2 = 10, s_1 = sqrt(1618/45), s_2 = sqrt(4469/90)$

  - 관측값 $f_0 = s_1^2 / s_2^2 = 3236 / 4469$

  - $Pr(F >= f_0) approx 0.6808, Pr(F <= f_0) approx 0.3192$

  - 유의확률 $min(2 times Pr(F >= f_0), 2 times Pr(F <= f_0)) = 0.6384 > alpha$

  - 유의수준 $alpha = 0.05$에서 귀무가설 기각 불가

- $therefore$ 유의수준 5%에서 두 집단의 분산이 확실히 다르다고 말할 수는 없다.

==== 모평균 비교

- 등분산 검정 결과에 따라 두 집단의 분산이 같다고 가정

- 가설:

  - 귀무가설 $hypothesis_0$: $mu_1 - mu_2 = 0$

  - 대립가설 $hypothesis_1$: $mu_1 - mu_2 > 0$

  - 유의수준 $alpha = 0.05$

- Let $T := ((overline(X_1) - overline(X_2)) - (mu_1 - mu_2))/(S_P sqrt(1 \/ n_1 + 1 \/ n_2))$

  - When $S_P = sqrt(1/(n_1 + n_2 - 2) (sum_(i = 1)^n_1 (X_(1i) - overline(X_1)^2) + sum_(i = 1)^n_2 (X_(2i) - overline(X_2))^2))$

  - And $overline(X_1) := 1/n_1 sum _(i = 1)^n_1 X_(1i), overline(X_2) := 1/n_2 sum _(i = 1)^n_2 X_(2i)$

- 귀무가설 $hypothesis _0$ 하에서

  - $T ~ t(n_1 + n_2 - 2)$

  - $n_1 = 10, n_2 = 10, s_p = sqrt(1541) / 6, overline(x_1) - overline(x_2) = 29 / 10$

  - 관측값 $t_0 = 0.9911$

  - 유의확률 $Pr(T >= t_0) approx 0.1674 > alpha$

  - 유의수준 $alpha = 0.05$에서 귀무가설 기각 불가

- $therefore$ 유의수준 5%에서 이 피임약이 혈압을 저하시킨다고 확실히 말할 수는 없다.

=== 6.3

- 1의 방법이 더 적합하다.

- 2의 방법의 경우 실험 대상의 개인차에 의한 영향을 배제할 수 없지만, 1의 방법의 경우 한 명의 실험자에 대해 두 약의 효과를 비교할 수 있기 때문에 더 적합하다.

== 7.1

- Let:

  - $p_1 :=$ 독감 백신 주사를 받은 사람 중 독감에 걸리지 않은 사람의 모비율

  - $p_2 :=$ 독감 백신 주사를 받지 않은 사람 중 독감에 걸리지 않은 사람의 모비율

  - $X_1 :=$ 독감 백신 주사를 받은 $n_1$명 중 독감에 걸리지 않은 사람의 수

    - $X_1 ~ B(n_1, p_1)$

  - $X_2 :=$ 독감 백신 주사를 받지 않은 $n_2$명 중 독감에 걸리지 않은 사람의 수

    - $X_2 ~ B(n_2, p_2)$

  - $X_1$과 $X_2$는 서로 독립


- Let $Z = ((hat(p)_1 - hat(p)_2) - (p_1 - p_2)) / sqrt(hat(p)_1 (1 - hat(p)_1)\/n_1 + hat(p)_2 (1 - hat(p)_2) \/ n_2)$

  - When $hat(p)_1 := X_1 / n_1, hat(p)_2 := X_2 / n_2$

  - 표본의 크기가 충분히 크므로 $Z homothetic N(0, 1)$

=== 7.1.(1)

- 가설:

  - 귀무가설 $hypothesis_0$: $p_1 - p_2 = 0$

  - 대립가설 $hypothesis_1$: $p_1 - p_2 > 0$

  - 유의수준 $alpha = 0.05$

- 귀무가설 $hypothesis_0$ 하에서

  - $Z = (hat(p)_1 - hat(p)_2) / sqrt(hat(p) (1 - hat(p)) (1 \/ n_1 + 1 \/ n_2)) homothetic N(0, 1)$

    - When $hat(p) := (X_1 + X_2) / (n_1 + n_2)$

  - 관측값 $z_0 = 1.827$

  - 유의확률 $Pr(Z > z_0) approx 0.03388 < alpha $

  - 유의수준 $alpha = 0.05$에서 귀무가설 기각

- $therefore$ 유의수준 5%에서 독감 백신이 독감에 걸리지 않을 확률을 높인다, 즉 독감 예방에 효과가 있다.

=== 7.1.(2)

- $Z = ((hat(p)_1 - hat(p)_2) - (p_1 - p_2)) / sqrt(hat(p)_1 (1 - hat(p)_1)\/n_1 + hat(p)_2 (1 - hat(p)_2) \/ n_2) homothetic N(0, 1)$ 이므로 $
  p_1 - p_2
  = (hat(p)_1 - hat(p)_2)
  - Z sqrt(
    (hat(p)_1 (1 - hat(p)_1)) / n_1
    + (hat(p)_2 (1 - hat(p)_2)) / n_2
  )
$

- $p_1 - p_2$의 95% 신뢰구간: $
  (hat(p)_1 - hat(p)_2)
  plus.minus z_(alpha \/ 2) sqrt(
    (hat(p)_1 (1 - hat(p)_1)) / n_1
    + (hat(p)_2 (1 - hat(p)_2)) / n_2
  )
$

  - When $alpha = 0.05$

- $(-0.00222, 0.09222)$

=== 7.1.(3)

- 분포 가정:

  - $(O_(i 1), O_(i 2)) tilde "Multi"(n_i, (p_(i 1), p_(i 2))), i = 1, 2$

  - When

    - $O_(11)$: 독감 백신 주사를 받은 사람 중 독감에 걸리지 않은 사람 수

    - $O_(12)$: 독감 백신 주사를 받은 사람 중 독감에 걸린 사람 수

    - $O_(21)$: 독감 백신 주사를 받지 않은 사람 중 독감에 걸리지 않은 사람 수

    - $O_(22)$: 독감 백신 주사를 받지 않은 사람 중 독감에 걸린 사람 수

    - $p_(11)$: 독감 백신 주사를 받은 사람 중 독감에 걸리지 않은 사람의 모비율

    - $p_(12)$: 독감 백신 주사를 받은 사람 중 독감에 걸린 사람의 모비율

    - $p_(21)$: 독감 백신 주사를 받지 않은 사람 중 독감에 걸리지 않은 사람의 모비율

    - $p_(22)$: 독감 백신 주사를 받지 않은 사람 중 독감에 걸린 사람의 모비율

- 가설 (동질성 검정):

  - 귀무가설 $hypothesis_0$: $p_(1 j) = p_(2 j) = p_j$

  - 대립가설 $hypothesis_1$: not $hypothesis_0$

  - 유의수준 $alpha = 0.05$

- Let $chi^2 := sum _(i = 1)^2 sum_(j = 1) ^2 (O_(i j) - hat(E)_(i j))^2 / hat(E)_(i j)$ (카이제곱 검정통계량)

  - When $hat(p)_j = (O_(1j) + O_(2j)) / (n_1 + n_2), hat(E)_(i j) =n_i hat(p)_j$ (기대도수)

- 귀무가설 $H_0$ 하에서

  - $chi^2 homothetic chi^2(1)$

  - $n_1 = 400, n_2 = 600, o_(11) = 340, o_(12) = 60, o_(21) = 483, o_(22) = 117$

  - $hat(p)_1 = 823 / 1000, hat(p)_2 = 177 / 1000$

  - 기대도수 $hat(E)_(11) = 1646 / 5, hat(E)_(12) = 354 / 5, hat(E)_(21) = 2469 / 5, hat(E)_(22) = 531 / 5$

  - 카이제곱 검정통계량 관측값 $chi^2_0 = 162000 / 48557 approx 3.3363$

  - 유의확률: $Pr(chi^2 >= chi^2_0) = 0.06777 > alpha$

  - 유의수준 $alpha= 0.05$에서 귀무가설 기각 불가

- 유의수준 5%에서 독감 백신이 독감에 걸릴 확률에 영향을 끼친다고 할 수 없다.

== 7.2

- 분포 가정:

  - $(O_(i 1), O_(i 2)) tilde "Multi"(n_i, (p_(i 1), p_(i 2))), i = 1, 2, 3$

  - When

    - $O_(i j)$: 주어진 표의 $i$행 $j$열에 대응되는 사람의 수

    - $p_(i j)$: 주어진 표의 $i$행 $j$열에 대응되는 사람의 모비율

- 가설 (독립성 검정):

  - 귀무가설 $hypothesis_0$: $p_(1j) = p_(2j) = p_(3j), j = 1, 2$

  - 대립가설 $hypothesis_1$: not $hypothesis_0$

  - 유의수준 $alpha = 0.05$

- Let $chi^2 = sum _(i = 1)^3 sum_(j = 1) ^2 (O_(i j) - hat(E)_(i j))^2 / hat(E)_(i j)$ (카이제곱 검정통계량)

  - When $hat(p)_j = (O_(1j) + O_(2j)) / (n_1 + n_2), hat(E)_(i j) = n_i hat(p)_j$ (기대도수)

- 귀무가설 $hypothesis_0$ 하에서

  - $chi^2 homothetic chi^2 (2)$

  - 카이제곱 검정통계량 관측값 $chi^2_0 = 0.1527$

  - $Pr(chi^2 >= chi^2_0) = 0.9265 >= alpha$

  - 유의수준 $alpha = 0.05$에서 귀무가설 기각 불가

- 유의수준 5%에서 연애기간의 길이가 결혼기간의 길이와 관계가 있다고 할 수 없다.