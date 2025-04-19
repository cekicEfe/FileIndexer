module BST
  ( BST(..),
    getElem,
    getBiggerBranch,
    getSmallerBranch,
    getBstNodeCount,
    bstToList,
    pushToBST,
    searchElem,
    searchAndUpdate,
  )
where

---------------------------elem-----lw-----gt
data BST a = EmptyBST | Node a (BST a) (BST a)

getElem :: BST a -> Maybe a
getElem EmptyBST = Nothing
getElem (Node a _ _) = Just a

getBiggerBranch :: BST a -> Maybe (BST a)
getBiggerBranch EmptyBST = Nothing
getBiggerBranch (Node _ _ gt) = Just gt

getSmallerBranch :: BST a -> Maybe (BST a)
getSmallerBranch EmptyBST = Nothing
getSmallerBranch (Node _ lt _) = Just lt

bstToList :: BST a -> [a]
bstToList tree = case getElem tree of
  Nothing -> []
  Just a -> a:smallerList++biggerList
  where
  smallerList = case getSmallerBranch tree of
    Nothing -> []
    Just node -> bstToList node
  biggerList = case getBiggerBranch tree of
    Nothing -> []
    Just node -> bstToList node
    
pushToBST :: (Ord a) => a -> BST a -> BST a
pushToBST psh EmptyBST = Node psh EmptyBST EmptyBST
pushToBST psh (Node elem lt gt)
  | psh == elem = Node elem lt gt
  | psh < elem = Node elem (pushToBST psh lt) gt
  | psh > elem = Node elem lt (pushToBST psh gt)
-- pushToBST _ (Node {}) = EmptyBST

searchAndUpdate :: (Ord a) => (a -> a -> a) -> a -> BST a -> BST a
searchAndUpdate _ _ EmptyBST = EmptyBST
searchAndUpdate f e (Node ele lt gt)
  | e == ele = Node (f e ele) lt gt
  | e < ele = Node ele (searchAndUpdate f e lt) gt
  | e > ele = Node ele lt (searchAndUpdate f e gt)
searchAndUpdate _ _ (Node {}) = EmptyBST

(??) :: (Ord a) => a -> BST a -> Bool
(??) _ EmptyBST = False
(??) srch (Node ele lt gt)
  | srch == ele = True
  | srch < ele = srch ?? lt
  | srch > ele = srch ?? gt
(??) _ (Node {}) = False

searchElem :: (Ord a) => a -> BST a -> Bool
searchElem = (??)

getBstNodeCount :: BST a -> Int
getBstNodeCount EmptyBST = 0
getBstNodeCount (Node _ lt gt) = 1 + getBstNodeCount lt + getBstNodeCount gt
