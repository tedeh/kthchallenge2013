import Data.List as List

main = do
  str <- getLine
  putStrLn $ show (solution str)

solution :: String -> Int
solution a =
  let counts = char_counts a
      unevens = filter (odd . snd) counts
      result = (length unevens) - 1
   in if result < 0 then 0 else result

char_counts :: String -> [(Char, Int)]
char_counts [] = []
char_counts (c:cs) =
  let stripped = filter (/= c) cs
      counts = 1 + (length cs) - (length stripped)
   in (c, counts) : (char_counts stripped)

