-- Garrett Scholtes
-- Lab 9 - CS4003
-- Hamming's Sequence

import System.Environment

--This is the generic version of merge (included for completeness of the lab--we don't
--need to use this for hamming, though).
merge [] [] = []
merge [] ls = ls
merge ls [] = ls
merge (a:ls1) (b:ls2) = if a < b then a:(merge ls1 (b:ls2)) else b:(merge (a:ls1) ls2)

-- For two brownies:
-- a version of merge which is the minimum needed to successfully
-- compute a Hamming's sequence, written in one line of code.
-- 
-- In the above, more-generic version of merge, we must consider the cases where the
-- first list is empty. However, notice that the first argument of merge will never be
-- empty while computing Hamming's sequence therefore we don't need to consider it.
mergeS (a:ls1) ls2 = if null ls2 then (a:ls1) else if a < head(ls2) then a:(mergeS ls1 ls2) else head(ls2):(mergeS (a:ls1) (tail ls2))

--Multiplies all elements in a list by the number c.
--I like my version because it takes advantage of currying
times c list = map (* c) list

--Generates a Hamming's sequence given a list of distinct primes in increasing order
--Notice we're using mergeS instead of merge.
hamming [] = []
hamming p = (head p):(mergeS (times (head p) (hamming p)) (hamming (tail p)))

--For five brownies:
--after compiling this program, you will be able to pass prime
--numbers into the executable as command line arguments, e.g.,
--    usr/~$ hamming 3 5 11
--    Primes entered:       [3,5,11]
--    First 30 in sequence: [3,5,9,11,15,25,27,33,45....
main = do
    argList <- getArgs
    let primes = (map read argList) :: [Int]
    putStr "Primes entered:       "
    print primes
    putStr "First 30 in sequence: "
    print $ take 30 $ hamming primes