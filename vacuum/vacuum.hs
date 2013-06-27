import Control.Monad
import Data.List

main = do
  properties <- getLine
  let tokens = words properties
      l1 = read (tokens !! 0) :: Int
      l2 = read (tokens !! 1) :: Int
      numTubes = read (tokens !! 2) :: Int
  rtubes <- sequence (replicate numTubes getLine)
  let tubes = map (\x -> (read x) :: Int) rtubes
  putStrLn $ solve tubes (l1, l2)

solve :: [Int] -> (Int, Int) -> String
solve t (l1, l2) = let g1 = largestSum t l1 l2
                       g2 = largestSum t l2 l1
                    in decideSolution g1 g2

decideSolution :: Maybe Int -> Maybe Int -> String
decideSolution Nothing Nothing = "Impossible"
decideSolution (Just a) Nothing = show a
decideSolution Nothing (Just b) = show b
decideSolution (Just a) (Just b) = show $ max a b

largestSum :: [Int] -> Int -> Int -> Maybe Int
largestSum t a b = let acombs = allCombs t
                       asums = filter ((<= a) . tupleSum) acombs
                    in if asums == [] then Nothing else
                        let amax = foldl1' tupleMax asums
                            bcombs = allCombs (stripCombs amax t)
                            bsums = filter ((<= b) . tupleSum) bcombs
                         in if bsums == [] then Nothing else
                             Just $ (tupleSum amax) + (tupleSum $ (foldl1' tupleMax bsums))

tupleSum :: (Num a) => (a,a) -> a
tupleSum (a,b) = a + b

tupleMax :: (Int,Int) -> (Int,Int) -> (Int,Int)
tupleMax a b | sa >= sb = a
             | otherwise = b
             where sa = tupleSum a
                   sb = tupleSum b

allCombs :: [Int] -> [(Int,Int)]
allCombs [] = []
allCombs (x:xs) = zip (repeat x) xs ++ allCombs xs

stripCombs :: (Int, Int) -> [Int] -> [Int]
stripCombs (a, b) list = delete a $ delete b list
