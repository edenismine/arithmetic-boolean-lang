{-|
Module      : EAB
Description : Simple implementación de la sintáxis del lenguaje de Expresiones Aritmético Booleanas
License     : MIT
Author      :
  - Luis Daniel Aragon Bermudez
  - César Gustavo Sánchez de la Rosa
Maintainer  :
  - daniel.aragon@ciencias.unam.mx
  - cesartavo@ciencias.unam.mx
-}
module EAB(
  Id,
  Exp(..),
  Sub,
  frVars,
  subst,
  alphaEq
) where

-- |Id. Un identificador de variable es una cadena.
type Id = String

-- |Exp. Representación de las expresiones aritmético-booleanas (EAB).
data Exp = V Id | I Int | B Bool | Add Exp Exp | Mul Exp Exp | Succ Exp | Pred Exp | Not Exp
         | And Exp Exp | Or Exp Exp | Lt Exp Exp | Gt Exp Exp | Eq Exp Exp | If Exp Exp Exp
         | Let Id Exp Exp deriving Eq

-- | Instancia Show para el tipo Exp
instance Show Exp where
  show e = case e of
    (V s)         -> "var[" ++ s ++ "]"
    (I n)         -> "num[" ++ show n ++ "]"
    (B b)         -> "bool[" ++ show b ++ "]"
    (Add e1 e2)   -> "add(" ++ show e1 ++ ", " ++ show e2 ++ ")"
    (Mul e1 e2)   -> "mul(" ++ show e1 ++ ", " ++ show e2 ++ ")"
    (Succ e1)     -> "succ(" ++ show e1 ++ ")"
    (Pred e1)     -> "pred(" ++ show e1 ++ ")"
    (Not e1)      -> "not(" ++ show e1 ++ ")"
    (And e1 e2)   -> "and(" ++ show e1 ++ ", " ++ show e2 ++ ")"
    (Or e1 e2)    -> "or(" ++ show e1 ++ ", " ++ show e2 ++ ")"
    (Lt e1 e2)    -> "lt(" ++ show e1 ++ ", " ++ show e2 ++ ")"
    (Gt e1 e2)    -> "gt(" ++ show e1 ++ ", " ++ show e2 ++ ")"
    (Eq e1 e2)    -> "eq(" ++ show e1 ++ ", " ++ show e2 ++ ")"
    (If c e1 e2)  -> "if(" ++ show c ++ ", " ++ show e1 ++ ", " ++ show e2 ++ ")"
    (Let i e1 e2) -> "let(" ++ show e1 ++ ", "++ i ++ "." ++ show e2 ++ ")"

-- |Sub. Formaliza el tipo de una substitución como una tupla del identificador de variable con la
-- expresión que debería reemplazarla.
type Sub = (Id, Exp)

-- |frVars. Devuelve la lista de variables libres en una EAB.
frVars :: Exp -> [Id]
frVars = frVarsAux [] []

-- |subst. Aplica una substitución en una EAB
subst :: Exp -> Sub -> Exp
subst = substAux []

-- |alphaEq. Determina si dos EAB son alfa-equivalentes.
alphaEq ::Exp -> Exp -> Bool
alphaEq = alphaEqAux []


-- |alphaEqAux. Esta función recursiva usa un acumulador para recolectar pares de variables en dos
-- expresiones, determina si son alfa-equivalentes verificando que todos los pares coincidan en
-- todas las apariciones locales.
alphaEqAux :: [(Id, Id)] -> Exp -> Exp -> Bool
alphaEqAux vars ex1 ex2 = case (ex1, ex2) of
  (V s1, V s2)               -> sameIndexes ((s1,s2):vars)
  (I n1, I n2)               -> n1 == n2 && sameIndexes vars
  (B b1, B b2)               -> b1 == b2 && sameIndexes vars
  (Add e1 e2, Add e3 e4)     -> alphaEqAux vars e1 e3 && alphaEqAux vars e2 e4
  (Mul e1 e2, Mul e3 e4)     -> alphaEqAux vars e1 e3 && alphaEqAux vars e2 e4
  (Succ e1, Succ e2)         -> alphaEqAux vars e1 e2
  (Pred e1, Pred e2)         -> alphaEqAux vars e1 e2
  (Not e1, Not e2)           -> alphaEqAux vars e1 e2
  (And e1 e2, And e3 e4)     -> alphaEqAux vars e1 e3 && alphaEqAux vars e2 e4
  (Or e1 e2, Or e3 e4)       -> alphaEqAux vars e1 e3 && alphaEqAux vars e2 e4
  (Lt e1 e2, Lt e3 e4)       -> alphaEqAux vars e1 e3 && alphaEqAux vars e2 e4
  (Gt e1 e2, Gt e3 e4)       -> alphaEqAux vars e1 e3 && alphaEqAux vars e2 e4
  (Eq e1 e2, Eq e3 e4)       -> alphaEqAux vars e1 e3 && alphaEqAux vars e2 e4
  (If c1 e1 e2, If c2 e3 e4) -> alphaEqAux vars c1 c2 && alphaEqAux vars e1 e3 && alphaEqAux vars e2 e4
  (Let x e1 e2, Let y e3 e4) -> alphaEqAux ((x,y):vars) e1 e3 && alphaEqAux ((x,y):vars) e2 e4
  _ -> False
  where sameIndexes [] = True
        sameIndexes ((s1,s2):bound) = all ((== s2) . snd) has && sameIndexes hasnt
          where (has, hasnt) = partition ((== s1) . fst) bound

-- |frVarsAux. Acumula las variables libres en una expresión.
frVarsAux :: [Id] -> [Id] -> Exp -> [Id]
frVarsAux free bounded e = case e of
  (V s)         -> if s `elem` bounded then free else s:free
  (I _)         -> free
  (B _)         -> free
  (Add e1 e2)   -> frVarsAux free bounded e1 ++ frVarsAux [] bounded e2
  (Mul e1 e2)   -> frVarsAux free bounded e1 ++ frVarsAux [] bounded e2
  (Succ e1)     -> frVarsAux free bounded e1
  (Pred e1)     -> frVarsAux free bounded e1
  (Not e1)      -> frVarsAux free bounded e1
  (And e1 e2)   -> frVarsAux free bounded e1 ++ frVarsAux [] bounded e2
  (Or e1 e2)    -> frVarsAux free bounded e1 ++ frVarsAux [] bounded e2
  (Lt e1 e2)    -> frVarsAux free bounded e1 ++ frVarsAux [] bounded e2
  (Gt e1 e2)    -> frVarsAux free bounded e1 ++ frVarsAux [] bounded e2
  (Eq e1 e2)    -> frVarsAux free bounded e1 ++ frVarsAux [] bounded e2
  (If c e1 e2)  -> frVarsAux free bounded c  ++ frVarsAux [] bounded e1 ++ frVarsAux [] bounded e2
  (Let i e1 e2) -> if i `elem` bounded then
    error $ "This binding for " ++ i ++ " shadows the existing binding" else
      frVarsAux free bounded e1 ++ frVarsAux [] (i:bounded) e2

-- |substAux. Dada la lista de variables ligadas, esta función ejecuta una sustitución en una EAB
-- recursivamente.
substAux :: [Id] -> Exp -> Sub -> Exp
substAux  bounded e s@(i, ex) = case e of
  (V v)
      | v /= i -> e
      | i `notElem` bounded && all (`notElem` bounded) (frVars ex) -> ex
      | otherwise ->  error "Could not perform the substitution"
  (I _)         -> e
  (B _)         -> e
  (Add e1 e2)   -> Add (substAux bounded e1 s) (substAux bounded e2 s)
  (Mul e1 e2)   -> Mul (substAux bounded e1 s) (substAux bounded e2 s)
  (Succ e1)     -> Succ (substAux bounded e1 s)
  (Pred e1)     -> Pred (substAux bounded e1 s)
  (Not e1)      -> Not (substAux bounded e1 s)
  (And e1 e2)   -> And (substAux bounded e1 s) (substAux bounded e2 s)
  (Or e1 e2)    -> Or (substAux bounded e1 s) (substAux bounded e2 s)
  (Lt e1 e2)    -> Lt (substAux bounded e1 s) (substAux bounded e2 s)
  (Gt e1 e2)    -> Gt (substAux bounded e1 s) (substAux bounded e2 s)
  (Eq e1 e2)    -> Eq (substAux bounded e1 s) (substAux bounded e2 s)
  (If c e1 e2)  -> If (substAux bounded c s) (substAux bounded e1 s) (substAux bounded e2 s)
  (Let i' e1 e2) -> if i' `elem` bounded then
    error $ "This binding for " ++ i' ++ " shadows the existing binding" else
      Let i' (substAux bounded e1 s) (substAux (i':bounded) e2 s)

-- |partition. Dado un predicado y una lista, esta función devuelve la tupla de listas cuyos
-- elementos corresponden a los elementos de la lista original que cumple y que no cumplen el
-- predicado, respectivamente.
partition :: (a -> Bool) -> [a] -> ([a], [a])
partition = partitionAux ([], [])

-- |partitionAux. Dado un acumulador, un predicado y una lista, esta función acumula la tupla de
-- listas cuyos elementos corresponden a los elementos de la lista original que cumple y que no
-- cumplen el predicado, respectivamente.
partitionAux :: ([a], [a]) -> (a -> Bool) -> [a] -> ([a], [a])
partitionAux acc _ [] = acc
partitionAux (yes,no) p (x:xs)
  | p x = partitionAux (x:yes, no) p xs
  | otherwise = partitionAux (yes, x:no) p xs
