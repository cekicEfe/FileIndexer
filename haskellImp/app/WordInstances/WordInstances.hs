module WordInstances
  ( WordInstances,
    putEntryToInstances,
    putEntryListToInstances,
    getTotalWordCount
  )
where

import BST
import WordEntry

type WordInstances = (BST WordEntry)

putEntryToInstances :: WordEntry -> WordInstances -> WordInstances
putEntryToInstances entry tree =
  if searchElem entry tree
    then searchAndUpdate mixEntry entry tree
    else pushToBST entry tree

getTotalWordCount :: WordInstances -> Int
getTotalWordCount EmptyBST = 0
getTotalWordCount (Node a lt gt) = getEntryNameCount a 
                                  + getTotalWordCount lt 
                                  + getTotalWordCount gt

putEntryListToInstances :: [WordEntry] -> WordInstances -> WordInstances
putEntryListToInstances [] tree = tree 
putEntryListToInstances (x : xs) tree =
  putEntryListToInstances xs (putEntryToInstances x tree)

