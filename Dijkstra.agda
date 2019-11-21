module Dijkstra where

open import Basics002

{- ****THE CODE***


G is the input graph, s is the source vertex, `(uv) is the length of an edge from u to v, and V is the set of
vertices.

Dijkstra(G, s)
  for all u ∈ V \ {s}, d(u) = ∞
  d(s) = 0
  R = {}
  while R ≠ V
    pick u ∉ R with smallest d(u)
    R = R ∪ {u}
    for all vertices v adjacent to u
      if d(v) > d(u) + `(u, v)
        d(v) = d(u) + `(u, v)
-}

postulate
  -- implement later
  _≡?ᵛ_ : ∀ {n : ℕ} → vec[ n ] 𝔹 → vec[ n ] 𝔹 → ≡!
  -- never implemented
  ∞ : ℕ

dijkstra-inner-loop : ∀ {n : ℕ} → graph[ n ] → idx n → idx n → vec[ n ] ℕ → vec[ n ] ℕ
dijkstra-inner-loop g u v d with g #[ u ] #[ v ]
… | O = {!d!} -- not adjacent
… | I = {!!}  -- is adjacent

--                                                            input                     output 
--                                               input        priority     output       priority
--                          whole graph  node    distances    queue        distances    queue
--                          ⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄   ⌄⌄⌄⌄⌄   ⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄   ⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄  ⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄   ⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄
dijkstra-loop : ∀ {n : ℕ} → graph[ n ] → idx n → vec[ n ] ℕ → vec[ n ] 𝔹 → vec[ n ] ℕ ∧ vec[ n ] 𝔹
dijkstra-loop g i d R with R ≡?ᵛ const[vec]< _ > I
… | [≡] = ⟨ d , R ⟩ -- done
… | [≢] = {!!} -- not done

-- this is what Dikjstra above in pseudocode corresponds to
dijkstra-vertex : ∀ {n : ℕ} → graph[ n ] → idx n → vec[ n ] ℕ
dijkstra-vertex = {!!}
 
dijkstra : ∀ {n : ℕ} → graph[ n ] → matrix[ n , n ] ℕ
dijkstra g = {!!}

{- ***THE PROOF***



Let d(v) be the label found by the algorithm and let δ(v) be the shortest path distance from s-to-v. We
want to show that d(v) = δ(v) for every vertex v at the end of the algorithm, showing that the algorithm
correctly computes the distances. We prove this by induction on |R| via the following lemma:

                    ****Lemma: For each x ∈ R, d(x) = δ(x).*****


Proof by Induction: Base case (|R| = 1): Since R only grows in size, the only time |R| = 1 is when R = {s} and d(s) = 0 = δ(s), which is correct.


Inductive hypothesis: Let u be the last vertex added to R. Let R0 = R∪ {u}. Our I.H. is: for each x ∈ R′, d(x) = δ(x).


Using the I.H.: By the inductive hypothesis, for every vertex in R′ that isn’t u, we have the correct distance label. We need only show that d(u) = δ(u) to complete the proof.


Suppose for a contradiction that the shortest path from s-to-u is Q and has length
                                  
                                 𝓁(Q) < d(u).


Q starts in R′ and at some leaves R′ (to get to u which is not in R′). Let xy be the first edge along Q that leaves R′. Let Qx be the s-to-x subpath of Q. Clearly:

                              𝓁(Qx) + 𝓁(xy) ≤ 𝓁(Q).


Since d(x) is the length of the shortest s-to-x path by the I.H., d(x) ≤ `(Qx), giving us

                              d(x) + `(xy) ≤ `(Qx).


Since y is adjacent to x, d(y) must have been updated by the algorithm, so

                               d(y) ≤ d(x) + `(xy).


Finally, since u was picked by the algorithm, u must have the smallest distance label:

                                     d(u) ≤ d(y).

Combining these inequalities in reverse order gives us the contradiction that d(x) < d(x). Therefore, no suCh shorter path Q must exist and so d(u) = δ(u).


This lemma shows the algorithm is correct by “applying” the lemma for R = V .
-}
