import Data.List
import Control.Monad
import Data.Char

main = do
  props <- getLine
  let totalWords = read (words props !! 0) :: Int
      totalPlates = read (words props !! 1) :: Int
  dict <- sequence (replicate totalWords getLine)
  plates <- sequence (replicate totalPlates getLine)
  let result = map (getFirstWord dict) $ map (map toLower) plates
  putStr $ unlines result

getFirstWord :: [String] -> String -> String
getFirstWord [] _ = "No valid word"
getFirstWord (dict:ds) word =
  if isWordMatching dict word then
    dict
  else
    getFirstWord ds word

isWordMatching :: String -> String -> Bool
isWordMatching dict [] = True
isWordMatching "" _ = False
isWordMatching dict (c:word) =
  let index = maybe (-1) id (elemIndex c dict)
   in if index == (-1) then False else isWordMatching (drop (index + 1) dict) word
