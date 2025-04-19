module WordEntry
  ( WordEntry (..),
    getEntryName,
    getEntryNameCount,
    getEntryFileInstances,
    wordToWordEntry,
    decideByWordCount,
    wordListToWordEntryList,
    mixFileInstances,
    mixEntry,
  )
where

import Data.Set as Set
-- import Data.List

data WordEntry = WordEntry
  { wordName :: String,
    wordCount :: Int,
    fileInstances :: [Int]
  }

getEntryName :: WordEntry -> String
getEntryName (WordEntry word_name _ _) = word_name

getEntryNameCount :: WordEntry -> Int
getEntryNameCount (WordEntry _ count _) = count

getEntryFileInstances :: WordEntry -> [Int]
getEntryFileInstances (WordEntry _ _ files) = files

-- LET IT BE WRITTEN HERE AND WOE FOR THE UNRESTED
-- IF YOU USE nub FOR UNIQUE ELEMS IN A LIST YOU ARE IN DEEP TROUBLE
-- FOR ITS QUADRATIC ... 
mixFileInstances :: (Ord a) => [a] -> [a]
mixFileInstances  = Set.toList . Set.fromList

-- rmdups :: Ord a => [a] -> [a]
-- rmdups = rmdups' Set.empty where
--   rmdups' _ [] = []
--   rmdups' a (b : c) = if Set.member b a
--     then rmdups' a c
--     else b : rmdups' (Set.insert b a) c

mergeSortedUnique :: Ord a => [a] -> [a] -> [a]
mergeSortedUnique [] ys = ys
mergeSortedUnique xs [] = xs
mergeSortedUnique (x:xs) (y:ys)
  | x < y     = x : mergeSortedUnique xs (y:ys)
  | x > y     = y : mergeSortedUnique (x:xs) ys
  | otherwise = x : mergeSortedUnique xs ys  -- x == y, so skip duplicate

wordToWordEntry :: String -> Int -> WordEntry
wordToWordEntry x fileIndex = WordEntry x 1 [fileIndex]

wordListToWordEntryList :: [String] -> Int -> [WordEntry]
wordListToWordEntryList [] _ = []
wordListToWordEntryList (s : ls) fileIndex = WordEntry s 1 [fileIndex] : wordListToWordEntryList ls fileIndex

-- Call this only when they are equal
mixEntry :: WordEntry -> WordEntry -> WordEntry
mixEntry (WordEntry n1 c1 fi1) (WordEntry _ c2 fi2) =
  WordEntry n1 (c1 + c2) (mergeSortedUnique fi1 fi2)

decideByWordCount :: WordEntry -> WordEntry -> Ordering
decideByWordCount (WordEntry _ c1 _) (WordEntry _ c2 _) 
  | c2 == c1 = EQ
  | c2 <  c1 = LT
  | c2 >  c1 = GT

instance Eq WordEntry where
  WordEntry a _ _ == WordEntry b _ _ = a == b

instance Ord WordEntry where
  WordEntry a1 _ _ <= WordEntry a2 _ _ = a1 <= a2
  WordEntry a1 _ _ < WordEntry a2 _ _ = a1 < a2
  WordEntry a1 _ _ > WordEntry a2 _ _ = a1 > a2

instance Show WordEntry where
  show (WordEntry name count files) = "\"" ++ name ++"\" count:" ++ show count 
    ++ " file instances:" ++ show files 
