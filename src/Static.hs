{-|
Module      : Static
Description : Simple implementación de la semántica estática de Expresiones Aritmético Booleanas
License     : MIT
Author      :
  - Luis Daniel Aragon Bermudez
  - César Gustavo Sánchez de la Rosa
Maintainer  :
  - daniel.aragon@ciencias.unam.mx
  - cesartavo@ciencias.unam.mx
-}
module Static where
import           EAB

data Type = Nat | Boolean deriving (Show, Eq)
type Declaration = (Id, Type)
type TypeContext = [Declaration]

-- |vt. Verifica el tipado de un programa tal que vt Γ e T = True syss Γ |- e : T.
vt :: TypeContext -> Exp -> Type -> Bool
vt ctx e t = case e of
  (V s)         -> (s, t) `elem` ctx
  (I n)         -> t == Nat
  (B b)         -> t == Boolean
  (Add e1 e2)   -> case t of
    Nat -> vt ctx e1 Nat && vt ctx e2 Nat
    Boolean -> False
  (Mul e1 e2)   -> case t of
    Nat -> vt ctx e1 Nat && vt ctx e2 Nat
    Boolean -> False
  (Succ e1)     -> case t of
    Nat -> vt ctx e1 Nat
    Boolean -> False
  (Pred e1)     -> case t of
    Nat -> vt ctx e1 Nat
    Boolean -> False
  (Not e1)      -> case t of
    Nat -> False
    Boolean -> vt ctx e1 Boolean
  (And e1 e2)   -> case t of
    Nat -> False
    Boolean -> vt ctx e1 Boolean && vt ctx e2 Boolean
  (Or e1 e2)    -> case t of
    Nat -> False
    Boolean -> vt ctx e1 Boolean && vt ctx e2 Boolean
  (Lt e1 e2)    -> case t of
    Nat -> False
    Boolean -> vt ctx e1 Nat && vt ctx e2 Nat
  (Gt e1 e2)    -> case t of
    Nat -> False
    Boolean -> vt ctx e1 Nat && vt ctx e2 Nat
  (Eq e1 e2)    -> case t of
    Nat -> False
    Boolean -> vt ctx e1 Nat && vt ctx e2 Nat
  (If c e1 e2)  -> vt ctx c Boolean && vt ctx e1 t && vt ctx e2 t
  (Let i e1 e2)
    | vt ctx e1 Nat -> vt ((i, Nat):ctx) e2 t
    | vt ctx e1 Boolean -> vt ((i, Nat):ctx) e2 t
    | otherwise -> False
