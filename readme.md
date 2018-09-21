Introducción
------------

A continuación se definen los juicios de la semántica dinámica de las
EAB.\vspace{5mm} \newline
\infer[(vtrue)]{\texttt{bool}[True] \texttt{ valor}}{} \hspace{2mm}
\infer[(vfalse)]{\texttt{bool}[False] \texttt{ valor}}{} \hspace{2mm}
\infer[(vnum)]{\texttt{num}[n] \texttt{ valor}}{} \vspace{5mm}\newline
\infer[(ftrue)]{\texttt{bool}[True] \texttt{ final}}{} \hspace{2mm}
\infer[(ffalse)]{\texttt{bool}[False] \texttt{ final}}{} \hspace{2mm}
\infer[(fnum)]{\texttt{num}[n] \texttt{ final}}{} \vspace{5mm}\newline
\infer[(eaddf)]{\texttt{add}(\texttt{num}[n],\texttt{num}[m])\rightarrow\texttt{num}[n+m]}{}\hspace{2mm}
\infer[(eaddi)]{\texttt{add}(t_1, t_2)\rightarrow\texttt{add}(t'_1,t_2)}{t_1\rightarrow t'_1}\vspace{5mm}\newline
\infer[(eaddd)]{\texttt{add}(\texttt{num}[n],t_2)\rightarrow\texttt{add}(\texttt{num}[n],t'_2)}{t_2\rightarrow t'_2}\vspace{5mm}\newline
\infer[(eprodf)]{\texttt{prod}(\texttt{num}[n],\texttt{num}[m])\rightarrow\texttt{num}[n+m]}{}\hspace{2mm}
\infer[(eprodi)]{\texttt{prod}(t_1, t_2)\rightarrow\texttt{prod}(t'_1,t_2)}{t_1\rightarrow t'_1}\vspace{5mm}\newline
\infer[(eprodd)]{\texttt{prod}(\texttt{num}[n],t_2)\rightarrow\texttt{prod}(\texttt{num}[n],t'_2)}{t_2\rightarrow t'_2}\vspace{5mm}\newline
\infer[(tpred0)]{\texttt{pred}(\texttt{num}[0])\rightarrow\texttt{num}[0]}{}\hspace{2mm}
\infer[(tpreds)]{\texttt{pred}(\texttt{num}[n+1])\rightarrow\texttt{num}[n]}{}\hspace{2mm}
\infer[(tpred)]{\texttt{pred}(t)\rightarrow\texttt{pred}(t')}{t\rightarrow t'}\vspace{5mm}\newline
\infer[(tsuccn)]{\texttt{succ}(\texttt{num}[n])\rightarrow\texttt{num}[n+1]}{}\hspace{2mm}
\infer[(tsucc)]{\texttt{succ}(t)\rightarrow\texttt{succ}(t')}{t\rightarrow t'}\vspace{5mm}\newline
\infer[(tnotb)]{\texttt{not}(\texttt{bool}[b])\rightarrow\texttt{bool}[\neg b]}{}\hspace{2mm}
\infer[(tnot)]{\texttt{not}(t)\rightarrow\texttt{not}(t')}{t\rightarrow t'}\vspace{5mm}\newline
\infer[(eandf)]{\texttt{and}(\texttt{bool}[b_1],\texttt{bool}[b_2])\rightarrow\texttt{bool}[b_1\land b_2]}{}\hspace{2mm}
\infer[(eandi)]{\texttt{and}(t_1, t_2)\rightarrow\texttt{and}(t'_1,t_2)}{t_1\rightarrow t'_1}\vspace{5mm}\newline
\infer[(eandd)]{\texttt{and}(\texttt{bool}[b],t_2)\rightarrow\texttt{and}(\texttt{bool}[b],t'_2)}{t_2\rightarrow t'_2}\vspace{5mm}\newline
\infer[(eorf)]{\texttt{or}(\texttt{bool}[b_1],\texttt{bool}[b_2])\rightarrow\texttt{bool}[b_1 \lor b_2]}{}\hspace{2mm}
\infer[(eori)]{\texttt{or}(t_1, t_2)\rightarrow\texttt{or}(t'_1,t_2)}{t_1\rightarrow t'_1}\vspace{5mm}\newline
\infer[(eord)]{\texttt{or}(\texttt{bool}[b],t_2)\rightarrow\texttt{or}(\texttt{bool}[b],t'_2)}{t_2\rightarrow t'_2}\vspace{5mm}\newline
\infer[(eltf)]{\texttt{lt}(\texttt{num}[n],\texttt{num}[m])\rightarrow\texttt{bool}[n < m]}{}\hspace{2mm}
\infer[(elti)]{\texttt{lt}(t_1, t_2)\rightarrow\texttt{lt}(t'_1,t_2)}{t_1\rightarrow t'_1}\vspace{5mm}\newline
\infer[(eltd)]{\texttt{lt}(\texttt{num}[n],t_2)\rightarrow\texttt{lt}(\texttt{num}[n],t'_2)}{t_2\rightarrow t'_2}\vspace{5mm}\newline
\infer[(egtf)]{\texttt{gt}(\texttt{num}[n],\texttt{num}[m])\rightarrow\texttt{bool}[n > m]}{}\hspace{2mm}
\infer[(egti)]{\texttt{gt}(t_1, t_2)\rightarrow\texttt{gt}(t'_1,t_2)}{t_1\rightarrow t'_1}\vspace{5mm}\newline
\infer[(egtd)]{\texttt{gt}(\texttt{num}[n],t_2)\rightarrow\texttt{gt}(\texttt{num}[n],t'_2)}{t_2\rightarrow t'_2}\vspace{5mm}\newline
\infer[(eeqf)]{\texttt{eq}(\texttt{num}[n],\texttt{num}[m])\rightarrow\texttt{bool}[n = m]}{}\hspace{2mm}
\infer[(eeqi)]{\texttt{eq}(t_1, t_2)\rightarrow\texttt{eq}(t'_1,t_2)}{t_1\rightarrow t'_1}\vspace{5mm}\newline
\infer[(eeqd)]{\texttt{eq}(\texttt{num}[n],t_2)\rightarrow\texttt{eq}(\texttt{num}[n],t'_2)}{t_2\rightarrow t'_2}\vspace{5mm}\newline
\infer[(eiffalse)]{\texttt{if}(\texttt{bool}[False],t_2, t_3)\rightarrow t_3}{}\hspace{2mm}
\infer[(eiftrue)]{\texttt{if}(\texttt{bool}[True],t_2, t_3)\rightarrow t_2}{}\vspace{5mm}\newline
\infer[(eif)]{\texttt{if}(t_1,t_2, t_3)\rightarrow\texttt{if}(t'_1,t_2, t_3)}{t_1\rightarrow t'_1}\vspace{5mm}\newline
\infer[(eletf)]{\texttt{let}(v,x.e_2)\rightarrow e_2[x:=v]}{v\texttt{ valor}}\hspace{2mm}
\infer[(eleti)]{\texttt{if}(t_1,x.e_2)\rightarrow\texttt{if}(t'_1,x.e_2)}{t_1\rightarrow t'_1}\vspace{5mm}\newline

A continuación se definen los juicios de la semántica estática de las
EAB. \vspace{5mm} \newline
\infer[(ttrue)]{\Gamma\vdash \texttt{bool[True]}:\texttt{Boolean}}{}
\hspace{2mm}
\infer[(tfalse)]{\Gamma\vdash \texttt{bool[False]}:\texttt{Boolean}}{}
\hspace{2mm} \infer[(tvar)]{\Gamma , x:T \vdash x:T}{}
\vspace{5mm}\newline
\infer[(tnum)]{\Gamma\vdash \texttt{num[n]}:\texttt{Nat}}{} \hspace{2mm}
\infer[(tadd)]{\Gamma\vdash \texttt{add}(t_1,t_2):\texttt{Nat}}{\Gamma\vdash t_1:\texttt{Nat} & \Gamma\vdash t_2:\texttt{Nat}}
\hspace{2mm}
\infer[(tmul)]{\Gamma\vdash \texttt{mul}(t_1,t_2):\texttt{Nat}}{\Gamma\vdash t_1:\texttt{Nat} & \Gamma\vdash t_2:\texttt{Nat}}
\vspace{5mm}\newline
\infer[(tsucc)]{\Gamma\vdash \texttt{succ}(t):\texttt{Nat}}{\Gamma\vdash t:\texttt{Nat}}
\hspace{2mm}
\infer[(tpred)]{\Gamma\vdash \texttt{pred}(t):\texttt{Nat}}{\Gamma\vdash t:\texttt{Nat}}
\hspace{2mm}
\infer[(tlt)]{\Gamma\vdash \texttt{lt}(t_1,t_2):\texttt{Boolean}}{\Gamma\vdash t_1:\texttt{Nat} & \Gamma\vdash t_2:\texttt{Nat}}
\vspace{5mm}\newline
\infer[(tgt)]{\Gamma\vdash \texttt{gt}(t_1,t_2):\texttt{Boolean}}{\Gamma\vdash t_1:\texttt{Nat}
 & \Gamma\vdash t_2:\texttt{Nat}} \hspace{2mm}
\infer[(teq)]{\Gamma\vdash \texttt{eq}(t_1,t_2):\texttt{Boolean}}{\Gamma\vdash t_1:\texttt{Nat}
 & \Gamma\vdash t_2:\texttt{Nat}} \hspace{2mm}
\infer[(tnot)]{\Gamma\vdash \texttt{not}(t):\texttt{Boolean}}{\Gamma\vdash t:\texttt{Boolean}}
\vspace{5mm}\newline
\infer[(tand)]{\Gamma\vdash \texttt{and}(t_1,t_2):\texttt{Boolean}}{\Gamma\vdash t_1:\texttt{Boolean} & \Gamma\vdash t_2:\texttt{Boolean}}
\hspace{2mm}
\infer[(tor)]{\Gamma\vdash \texttt{or}(t_1,t_2):\texttt{Boolean}}{\Gamma\vdash t_1:\texttt{Boolean} & \Gamma\vdash t_2:\texttt{Boolean}}
\vspace{5mm}\newline
\infer[(tif)]{\Gamma\vdash \texttt{if}(t_1,t_2,t_3):T}{\Gamma\vdash t_1:\texttt{Boolean} & \Gamma\vdash t_2:T & \Gamma\vdash t_3:T}
\hspace{2mm}
\infer[(tor)]{\Gamma\vdash \texttt{or}(t_1,t_2):\texttt{Boolean}}{\Gamma\vdash t_1:\texttt{Boolean} & \Gamma\vdash t_2:\texttt{Boolean}}
\vspace{5mm}\newline
\infer[(tlet)]{\Gamma\vdash \texttt{let}(e_1,x.e_2):S}{\Gamma\vdash e_1:T & \Gamma , x:T\vdash e_2:S}
\newline

Ejecución
---------

Utilizando cabal de @cabal es sencillo cargar los ejemplos usando el
siguiente comando:

> `$ cabal repl`

Y una vez en la REPL, puede correr cada uno de los ejemplos o todos
usando el `main`:

> `*Examples> main`

A continuación se muestran los ejemplos disponibles.

``` {.haskell}
------------------------------
---------- EJEMPLOS ----------
------------------------------

eval1Ej1 :: Exp
eval1Ej1 = eval1 (Add (I 1) (I 2))
-- >> num[3]

eval1Ej2 :: Exp
eval1Ej2 = eval1 (Mul (I 4) (I 0))
-- >> num[0]

eval1Ej3 :: Exp
eval1Ej3 = eval1 (Let "y" (I 10) (Mul (V "y") (I 2)))
-- >> mul(num[10], num[2])

eval1Ej4 :: Exp
eval1Ej4 = eval1 (Let "y" (Succ (I 0)) (Lt (V "y") (I 0)))
-- >> let(num[1], y.lt(var[y], num[0]))

eval1Ej5 :: Exp
eval1Ej5 = eval1 (Let "y" (Add (I 2) (I 3)) (Mul (V "y") (I 0)))
-- >> let(num[5], y.mul(var[y], num[0]))

evalsEj1 :: Exp
evalsEj1 = evals (Mul (Mul (I 10) (I 2)) (B False))
-- >> mul(num[20], bool[False])

evalsEj2 :: Exp
evalsEj2 = evals (Let "y" (Succ (I 0)) (Lt (V "y") (I 0)))
-- >> bool[False]

evalsEj3 :: Exp
evalsEj3 =  evals (Let "y" (Pred (I 11)) (Lt (V "y") (I 10)))
-- >> bool[False]

evalsEj4 :: Exp
evalsEj4 =  evals (Let "y" (Mul (I 10) (I 10))
                (Eq (V "y") (I 100)))
-- >> bool[True]

evalsEj5 :: Exp
evalsEj5 =  evals (Let "y" (And (B True) (B True))
                (Or (V "y") (B False)))
-- >> bool[True]

evalEj1 :: Exp
evalEj1 = eval (Add (Mul (I 1) (I 6)) (I 9))
-- >> num[15]

evalEj2 :: Exp
evalEj2 =  eval (Succ (Mul (I 1) (I 6)))
-- >> num[7]

evalEj3 :: Exp
evalEj3 = eval (Pred (B True))
-- >> *** Exception: [Pred] requires a number ...

evalEj4 :: Exp
evalEj4 = eval (And (Eq (I 2) (I 2)) (Eq (Add (I 1) (I 1)) (I 2) ))
-- >> bool[True]

evalEj5 :: Exp
evalEj5 = eval (And (Eq (Mul (I 2) (I 4)) (Pred (I 9)))
  (Or (Eq (Add (I 4) (I 4)) (I 0) ) (B False)))
-- >> bool[False]

vtEj1 :: Bool
vtEj1 = vt [("x", Boolean)] (And (Eq (Mul (I 2) (I 4)) (Pred (I 9)))
  (Or (Eq (Add (I 4) (I 4)) (I 0) ) (V "x"))) Boolean
-- >> True

vtEj2 :: Bool
vtEj2 = vt [("x", Boolean)] (And (Eq (Mul (I 2) (I 4)) (Pred (I 9)))
  (Or (Eq (Add (I 4) (I 4)) (I 0) ) (V "x"))) Nat
-- >> False

vtEj3 :: Bool
vtEj3 = vt [("y", Boolean)] (And (And (B True) (B True))
  (Or (V "y") (B False))) Boolean
-- >> True

vtEj4 :: Bool
vtEj4 = vt [] (Let "x" (Add (I 1) (I 2))
  (Eq (Mul (Add (V "x") (I 5)) (I 0)) (Add (V "x") (I 2)))) Boolean
-- >> True

vtEj5 :: Bool
vtEj5 = vt [("x", Nat)] (Let "y" (Add (I 1) (I 2))
  (Eq (Mul (Add (V "x") (I 5)) (I 0)) (Add (V "x") (I 2)))) Boolean
-- >> True
```

Implementación
--------------

Se incluye una implementación de la semántica de las Expresiones
Aritmético Booleanas (**EAB**) cuya tipo de Haskell puede verse a
continuación.

``` {.haskell language="Haskell"}
data Exp = V Id | I Int | B Bool | Add Exp Exp 
| Mul Exp Exp | Succ Exp | Pred Exp | Not Exp 
| And Exp Exp | Or Exp Exp | Lt Exp Exp | Gt Exp Exp 
| Eq Exp Exp | If Exp Exp Exp | Let Id Exp Exp deriving (Eq)
```

Además, se implementaron dos semánticas de las EAB.

### Semántica dinámica

Se implementaron las siguientes funciones principales:

-   **eval1**. Devuelve la transición $e'$ tal que `eval1` $e$ =
    $e’ \iff e \rightarrow e'$.
-   **evals**. Dado $e$, devuelve $e'$ si existe $e'$ tal que
    $e \rightarrow^* e'$ y $e'$ está bloqueado.
-   **eval**. Devuelve la evaluación de un programa tal que `eval` $e$ =
    $e' \iff e \rightarrow^* e'$ y $e'$ es un valor. En caso de que $e'$
    no sea un valor muestra un mensaje de error.

La parte más importante fue detectar los estados bloqueados en `eval1`
usando el tipo `Maybe`. Después fue fácil implementar `evals` en
términos de `eval1` y `eval` en términos de `evals`. Para `eval` además,
nos ayudamos del tipo `Either` para guardar nuestros mensajes de error.

### Semántica estática

Se implementó la siguiente función:

-   **vt**. Verifica el tipado de un programa tal que `vt` $\Gamma$ `e`
    $T$ = `True` $\iff\Gamma \vdash$ `e` : $T$.

Bibliografía
------------
