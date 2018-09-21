module Examples where
import           Dynamic
import           EAB
import           Static

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

main::IO()
main = do {
  putStrLn $ "eval1Ej1\n>> " ++ show eval1Ej1 ++ "\n";
  putStrLn $ "eval1Ej2\n>> " ++ show eval1Ej2 ++ "\n";
  putStrLn $ "eval1Ej3\n>> " ++ show eval1Ej3 ++ "\n";
  putStrLn $ "eval1Ej4\n>> " ++ show eval1Ej4 ++ "\n";
  putStrLn $ "eval1Ej5\n>> " ++ show eval1Ej5 ++ "\n";
  putStrLn $ "evalsEj1\n>> " ++ show evalsEj1 ++ "\n";
  putStrLn $ "evalsEj2\n>> " ++ show evalsEj2 ++ "\n";
  putStrLn $ "evalsEj3\n>> " ++ show evalsEj3 ++ "\n";
  putStrLn $ "evalsEj4\n>> " ++ show evalsEj4 ++ "\n";
  putStrLn $ "evalsEj5\n>> " ++ show evalsEj5 ++ "\n";
  putStrLn $ "evalEj1\n>> " ++ show evalEj1 ++ "\n";
  putStrLn $ "evalEj2\n>> " ++ show evalEj2 ++ "\n";
  putStrLn $ "evalEj4\n>> " ++ show evalEj4 ++ "\n";
  putStrLn $ "evalEj5\n>> " ++ show evalEj5 ++ "\n";
  putStrLn $ "vtEj1\n>> " ++ show vtEj1 ++ "\n";
  putStrLn $ "vtEj2\n>> " ++ show vtEj2 ++ "\n";
  putStrLn $ "vtEj3\n>> " ++ show vtEj3 ++ "\n";
  putStrLn $ "vtEj4\n>> " ++ show vtEj4 ++ "\n";
  putStrLn $ "vtEj5\n>> " ++ show vtEj5 ++ "\n";
  putStrLn $ "evalEj3\n>> " ++ show evalEj3 ++ "\n";
}
