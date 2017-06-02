-- Garrett Scholtes
-- Lab 10 - CS4003
-- Fractional Knapsack problem

-- 1. What type is this list?:
--   higgins = ["The", "rain", "in", "spain", "falls", "mainly", "on", "the", "plain"]
-- higgins is of the type [[Char]] (this makes sense because [Char] is basically a
-- string so this would be a list of strings, hence [[Char]])

-- 2. Create a haskell function that solves the fractional Knapsack problem.
-- Input is of the form:
--     [("label 1", value, weight), ("label 2", value, weight), ...]
-- and output is of the form:
--     [("label 1", value, solution_weight), ("label 2", value, solution_weight), ...]
--
-- How to use/test:
--   -Load "knapsack.hs" into ghci
--   -Run the following:
--       knapsack sample_input 15
--   -Expected output:
--       [
--          ("E",10.0,4.0),
--          ("B",2.0,1.0),
--          ("C",2.0,2.0),
--          ("D",1.0,1.0),
--          ("A",2.3333333333333335,7.0)
--       ]


sample_input = [
        ("A",4,12),
        ("B",2,1),
        ("C",2,2),
        ("D",1,1),
        ("E",10,4)
    ] :: [([Char], Double, Double)]

-- This function changes a list from [(name, value, weight)] to
-- [(name, value/weight, weight)]
manip lst = [(name, v/w, w) | (name, v, w) <- lst]

-- This function undoes the above
unmanip lst = [(name, r*w, w) | (name, r, w) <- lst]

-- Gets the first element in a tuple
first (x, _, _) = x
-- Gets the second element in a tuple
sec (_, x, _) = x
-- Gets the third element in a tuple
third (_, _, x) = x

-- Everything below does mergesort.  Mostly adapted from code given in class, but
-- modified to match the type [([Char], Double, Double)]
-- Note: sorts in descending order

mrg :: (Ord x) => [(t, x, t1)] -> [(t, x, t1)] -> [(t, x, t1)]
mrg [] [] = []
mrg a [] = a
mrg [] a = a
mrg (a:ls1) (b:ls2) =
    if (sec a) >= (sec b) then a:(mrg ls1 (b:ls2))
    else b:(mrg (a:ls1) ls2)

-- Split a list: keep even indexed items
splite [] = []
splite (a:[]) = [a]
splite (a:b:x) = a : splite x

-- Split a list: keep odd indexed items
splito [] = []
splito (a:[]) = []
splito (a:b:x) = b : splito x

-- Mergesort
srt :: Ord a => [(t, a, t1)] -> [(t, a, t1)]
srt [] = []
srt (b:[]) = [b]
srt x = mrg (srt (splite x)) (srt (splito x))

-- This is actually where the meat of the problem takes place.  This function
-- assumes that the list is already sorted in descending order by value to weight
-- ratio, where a list has tuples of the form (label, value, weight)
knap_helper :: [([Char],Double,Double)] -> Double -> [([Char],Double,Double)]
knap_helper [] weight = []
knap_helper lst weight
    | weight <= 0 = []
    | w >= weight = [(label, v*(weight/w), weight)]
    | otherwise = (head lst):(knap_helper (tail lst) (weight - w))
    where label = first (head lst)
          v = sec (head lst)
          w = third (head lst)

-- Parameters:
--     input :: [([Char], Double, Double)]
--         - a list of items that can be placed in the knapsack.  The first
--         - element of each tuple is the name/label of that item. t is the
--         - value of the item, and t1 is the weight of the item
--     weight :: Double - the weight limit of the knapsack
--     
-- Return value:
--     [(label, value, weight), ...]
--         - Gives a list of tuples where the first tuple is the first item
--         - that a thief should grab and the last item is the item that the
--         - thief only takes a fraction of.
--         - The weights and values are NOT accumulative, i.e., all tuples but
--         - the last will have the same value and weight in the output as in
--         - the input.
knapsack :: [([Char],Double,Double)] -> Double -> [([Char],Double,Double)]
knapsack input weight = knap_helper (unmanip (srt (manip input))) weight