module FileIndexer
  ( parseFile,
    getRid,
    getFileContent,
    getFileIndex,
    indexFiles,
    indexGoDoItNow
    -- File(..)
  )
where

import BST
import WordEntry
import WordInstances

import Control.DeepSeq
import System.Environment
import Data.List
import Text.Read
import Data.Char

-- I sadly didn't even need this ...
type File = ([String],Int)

getFileContent :: File -> [String]
getFileContent (content,_) = content

getFileIndex :: File -> Int
getFileIndex (_,index) = index

getRid :: Char -> Char
getRid char
  | char <= 'Z' && char >= 'A' = char
  | char <= 'z' && char >= 'a' = char
  | otherwise = ' '

-- If you are reading this you are wondering
-- Like all of us ...
-- But if you are concerned about efficiency
-- Dont. This is lazily evaluated
-- this takes PATH 
parseFile :: (String,Int) -> IO ([String],Int)
parseFile (fileName,fileIndex) = do
  x <- readFile fileName
  let res = (words $ map (getRid . toLower) x,fileIndex)
  return $!! res

indexFiles :: (String,Int,WordInstances) -> Int -> IO(String,Int,WordInstances)
indexFiles (fileName,fileIndex,tree) maxIndex =
  if fileIndex > maxIndex then return (fileName,fileIndex,tree)
  else do 
    file <- parseFile (fileName,fileIndex)
    let entryList = wordListToWordEntryList (getFileContent file) fileIndex
    indexFiles (show (fileIndex+1)++".txt",fileIndex+1,putEntryListToInstances entryList tree) maxIndex

readMyArgsDammit :: String -> Maybe Int
readMyArgsDammit = readMaybe

indexGoDoItNow :: IO()
indexGoDoItNow = do
  args <- getArgs 
  if null args then
    print "No args given, usage : haskellImp <int>"
  else if length args == 1 then
    case readMyArgsDammit $ head args of
      Nothing -> do print "Invalid arg type, usage: haskellImp <int>"
      Just _ -> 
        do
        (_,_,tree) <- indexFiles ("1.txt",1,EmptyBST) $ read $ head args

        let treeToList = bstToList tree
        let most10 = take 10 $ sortBy decideByWordCount treeToList  
        let least10 = take 10 $ sortBy (flip decideByWordCount) treeToList
        print most10
        print least10
    
        let totalNodeCount = getBstNodeCount tree
        let totalWordCount = getTotalWordCount tree
        
        print $ "Unique word count : " ++ show totalNodeCount
        print $ "Total word count : " ++ show totalWordCount
  else print "More than one args given, usage : haskellImp <int>"

