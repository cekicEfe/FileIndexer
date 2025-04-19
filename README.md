# FileIndexer
Basic FileIndexer in both c++ and haskell

## What is This ?!
This is a basic file indexer,
This program searches all words in specific files
returns most and least occured 10 words and the file index that was found in

**Only** works on files that has number for name (file extension must be .txt)
File names should be consecutive

### Example:
> ./haskellImp 5
this will search and index files:
> 1.txt
> 2.txt
> 3.txt
> 4.txt
> 5.txt
and will throw error if for example 3.txt was not found
I was lazy to pass them arguments :(

## How to build haskellImp
To build Haskell version :
### If you are using nix
Just use this

```
cd haskellImp
nix-shell
```
 
This will put the program in temporary shell
### If you dont have nix
You must download cabal and ghc for this 

```
cd haskellImp
cabal build
```

and your program should be built

## I haven't finished cpp version yet :( 
