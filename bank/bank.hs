import Data.List

type Money = Integer
type WaitingTime = Integer
type TimeToClose = Integer
type Person = (Money, WaitingTime)
type Queue = [Person]

readPerson :: String -> Person
readPerson s = let money = read (words s !! 0) :: Money
                   time = read (words s !! 1) :: Money
                in (money, time)

main = do
  mprops <- getLine 
  let peopleInQueue = read (words mprops !! 0) :: Int
      timeToClose = read (words mprops !! 1) :: TimeToClose
  mpersons <- sequence $ replicate peopleInQueue getLine
  let queue = map readPerson mpersons
  putStrLn $ show (solve timeToClose queue)

solve :: TimeToClose -> Queue -> Money
solve 0 _ = 0
solve _ [] = 0
solve t q = let line = map (\n -> filter (\m -> (snd m) == n) q) [0..t]
             in solveIterate 0 (reverse line) []

solveIterate :: Money -> [Queue] -> Queue -> Money
solveIterate m [] _ = m
solveIterate m ([]:line) [] = solveIterate m line []
solveIterate m (c:line) q = let qs = (c ++ q)
                                max = maximumBy (\x y -> compare (fst x) (fst y)) qs
                                qn = delete max qs
                             in solveIterate ((fst max) + m) line qn
