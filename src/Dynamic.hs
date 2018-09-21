{-|
Module      : Dynamic
Description : Simple implementación de la semántica dinámica de Expresiones Aritmético Booleanas
License     : MIT
Author      :
  - Luis Daniel Aragon Bermudez
  - César Gustavo Sánchez de la Rosa
Maintainer  :
  - daniel.aragon@ciencias.unam.mx
  - cesartavo@ciencias.unam.mx
-}
module Dynamic where
import           EAB

type Exception = String

-- | eval1. Devuelve la transición tal que eval1 e = e’ syss e -> e'.
eval1 :: Exp -> Exp
eval1 e = case safeEval1 e of
  (Just e') -> e'
  Nothing   -> error "can't evaluate blocked state"

-- | evals. Dado e, devuelve e' si existe e' tal que e ->* e' y e' está bloqueado.
evals :: Exp -> Exp
evals e = case safeEvals e of
  (Just e') -> e'
  Nothing   -> undefined

-- |eval. Devuelve la evaluación de un programa tal que eval e = e’ syss e->* e' y e' es
-- un valor. En caso de que e' no sea un valor muestra un mensaje de error.
eval :: Exp -> Exp
eval e = case safeEval e of
  (Left e')   -> e'
  (Right err) -> error err

-- | isBlocked. Checa si una expresión es bloqueada.
isBlocked :: Exp -> Bool
isBlocked e = case safeEval1 e of
  (Just _) -> False
  Nothing  -> True

-- | safeEval1. Dado e, devuelve Just e' si existe e' tal que e -> e', o Nothing en otro caso.
safeEval1 :: Exp -> Maybe Exp
safeEval1 e = case e of
  (V s)                -> Nothing
  (I n)                -> Nothing
  (B b)                -> Nothing
  (Add (I n1) (I n2))  -> Just $ I (n1 + n2)
  (Add (I n1) e2)      -> case safeEval1 e2 of
    (Just e') -> Just $ Add (I n1) e'
    Nothing   -> Nothing
  (Add e1 e2)          -> case safeEval1 e1 of
    (Just e') -> Just $ Add e' e2
    Nothing   -> Nothing
  (Mul (I n1) (I n2))  -> Just $ I (n1 * n2)
  (Mul (I n1) e2)      -> case safeEval1 e2 of
    (Just e') -> Just $ Mul (I n1) e'
    Nothing   -> Nothing
  (Mul e1 e2)          -> case safeEval1 e1 of
    (Just e') -> Just $ Mul e' e2
    Nothing   -> Nothing
  (Succ (I n1))        -> Just $ I (n1 + 1)
  (Succ e1)            -> case safeEval1 e1 of
    (Just e') -> Just $ Succ e'
    Nothing   -> Nothing
  (Pred (I n1))        -> Just $ if n1 <= 0 then I 0 else I (n1 - 1)
  (Pred e1)            -> case safeEval1 e1 of
    (Just e') -> Just $ Pred e'
    Nothing   -> Nothing
  (Not (B b1))         -> Just $ B (not b1)
  (Not e1)             -> case safeEval1 e1 of
    (Just e') -> Just $ Not e'
    Nothing   -> Nothing
  (And (B b1) (B b2))  -> Just $ B (b1 && b2)
  (And (B b1) e2)      -> case safeEval1 e2 of
    (Just e') -> Just $ And (B b1) e'
    Nothing   -> Nothing
  (And e1 e2)          -> case safeEval1 e1 of
    (Just e') -> Just $ And e' e2
    Nothing   -> Nothing
  (Or (B b1) (B b2))   -> Just $ B (b1 || b2)
  (Or (B b1) e2)      -> case safeEval1 e2 of
    (Just e') -> Just $ Or (B b1) e'
    Nothing   -> Nothing
  (Or e1 e2)          -> case safeEval1 e1 of
    (Just e') -> Just $ Or e' e2
    Nothing   -> Nothing
  (Lt (I n1) (I n2))   -> Just $ B (n1 < n2)
  (Lt (I n1) e2)       -> case safeEval1 e2 of
    (Just e') -> Just $ Lt (I n1) e'
    Nothing   -> Nothing
  (Lt e1 e2)           -> case safeEval1 e1 of
    (Just e') -> Just $ Lt e' e2
    Nothing   -> Nothing
  (Gt (I n1) (I n2))   -> Just $ B (n1 > n2)
  (Gt (I n1) e2)       -> case safeEval1 e2 of
    (Just e') -> Just $ Gt (I n1) e'
    Nothing   -> Nothing
  (Gt e1 e2)           -> case safeEval1 e1 of
    (Just e') -> Just $ Gt e' e2
    Nothing   -> Nothing
  (Eq (I n1) (I n2))   -> Just $ B (n1 == n2)
  (Eq (I n1) e2)       -> case safeEval1 e2 of
    (Just e') -> Just $ Eq (I n1) e'
    Nothing   -> Nothing
  (Eq e1 e2)           -> case safeEval1 e1 of
    (Just e') -> Just $ Eq e' e2
    Nothing   -> Nothing
  (If (B True) e1 e2)  -> Just e1
  (If (B False) e1 e2) -> Just e2
  (If c e1 e2)         -> case safeEval1 c of
    (Just c') -> Just $ If c' e1 e2
    Nothing   -> Nothing
  (Let i (I n) e2)     -> Just $ subst e2 (i, I n)
  (Let i (B b) e2)     -> Just $ subst e2 (i, B b)
  (Let i e1 e2)        -> case safeEval1 e1 of
    (Just e') -> Just $ Let i e' e2
    Nothing   -> Nothing

-- | safeEvals. Dado e, devuelve Just e' si existe e' tal que e ->* e' y e' está bloqueado.
safeEvals :: Exp -> Maybe Exp
safeEvals e = if isBlocked e then Just e else safeEvals (eval1 e)

-- |safeEval. Devuelve la evaluación de un programa tal que safeEval e = Left e’ syss e->* e' y e'
-- es un valor. En caso de que e' no sea un valor devuelve un mensaje de error envuelto en un Right.
safeEval :: Exp -> Either Exp Exception
safeEval e = case safeEvals e of
  (Just e') -> case e' of
    (V s)         -> Right $ "blocked free variable in " ++ s
    (I n)         -> Left e'
    (B b)         -> Left e'
    (Add e1 e2)   -> Right $ "[Add] requires two numbers in " ++ show e'
    (Mul e1 e2)   -> Right $ "[Mul] requires two numbers in " ++ show e'
    (Succ e1)     -> Right $ "[Succ] requires a number in " ++ show e'
    (Pred e1)     -> Right $ "[Pred] requires a number greater than 0 in " ++ show e'
    (Not e1)      -> Right $ "[Not] requires a boolean in " ++ show e'
    (And e1 e2)   -> Right $ "[And] requires two booleans in " ++ show e'
    (Or e1 e2)    -> Right $ "[Or] requires two booleans in " ++ show e'
    (Lt e1 e2)    -> Right $ "[Lt] requires two numbers in " ++ show e'
    (Gt e1 e2)    -> Right $ "[Gt] requires two numbers in " ++ show e'
    (Eq e1 e2)    -> Right $ "[Eq] requires two numbers in " ++ show e'
    (If c e1 e2)  -> Right $ "[If] requires a boolean condition in " ++ show e'
    (Let i e1 e2) -> Right $ "[Let] requires a value in " ++ show e'
  Nothing -> Right "undefined state"
