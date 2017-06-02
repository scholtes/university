-- Garrett Scholtes
-- Lab 11 - CS4003
-- Bloom filter

-- Implement a simple bloom filter
-- (See end of file for sample usage)

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- For the sake of this lab, these values are hardcoded
-- Number of bits in the database array
nbits :: Int
nbits = 31
-- Number of hash functions
k :: Int
k = 3

---------------------------------------------------------------------------------------------------

-- Hash function
-- This produces a hash function that can be applied to a string (i.e., [Char])
-- For example,
--     ((f 17 34) "Hello")
-- gives 13
f :: Int -> Int -> [Char] -> Int
f modulus seed = foldl (\acc x -> ((acc*(fromEnum x) `mod` modulus)+1)) seed

-- Multiple hash functions
-- This applies several hash functions to a string and gives a list of hashes
hashes :: [Char] -> [Int]
hashes str = [(f nbits seed) str | seed <- [0..(k-1)]]

-- Adds a string to the database
-- First argument is an existing database
-- Second argument is string to add to database
-- Result is the new database (note that nbits and k do not change)
addToDB :: [Bool] -> [Char] -> [Bool]
addToDB db str = addToDBHelper db (hashes str)

-- Adds a string to the database given the hashes of that string
addToDBHelper :: [Bool] -> [Int] -> [Bool]
addToDBHelper db [] = db
addToDBHelper db (a:ls) = addToDBHelper ((take (a-1) db)++[True]++(takeLast (nbits-a) db)) ls
-- Like take, but from the end of the list
takeLast :: Int -> [a] -> [a]
takeLast n ls = zplftvr (drop n ls) ls
-- Helper for takeLast
zplftvr :: [a] -> [a] -> [a]
zplftvr [] [] = []
zplftvr ls [] = ls
zplftvr [] ls = ls
zplftvr (a:ls1) (b:ls2) = zplftvr ls1 ls2

-- Makes a database from scratch, given a collection of strings to be added
-- First argument is the list of strings to be added to the database
-- Results is the database
makeDB :: [[Char]] -> [Bool]
makeDB [] = [False | n <- [1..nbits]]
makeDB (a:strs) = addToDB (makeDB strs) a

-- Queries the database for an entry to test set membership
-- Result: Just False if not in database, Nothing if it cannot be determined
query :: [Char] -> [Bool] -> Maybe Bool
query str db =
    if found then
        Nothing
    else
        Just False
    where
        found = foldl (\acc hash -> acc && (db !! (hash-1))) True (hashes str)

-- Represent database as a string, for testing purposes and your convenience
printDB :: [Bool] -> [Char]
printDB [] = ""
printDB (a:ls) = (if a then '1' else '0'):(printDB ls)

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-- Sample usage --
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- Let's create an example database db1 and populate it with these strings
db1 = makeDB ["Hello", "world", "and", "all", "who", "inhabit", "it"]
db1str = printDB db1
--       ::: 1111000000100110010010111110001

-- Let's test that these things may be in the database (but unknowable), so
-- running (query str db1) for each string will give Nothing
testDb1_1 = map (\str -> query str db1) ["Hello", "world", "and", "all", "who", "inhabit", "it"]
--      ::: [Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing]

-- Let's test that these things are definitely not (or maybe not) in the database, so
-- running (query str db1) for each string should give Just False, but sometimes it might
-- give a "false positive" in the form of Nothing
testDb1_2 = map (\str -> query str db1) ["These", "words", "are", "not", "in", "the", "database"]
--      ::: [Just False, Nothing, Just False, Just False, Just False, Just False, Just False]

-- Let's test out the addToDB function by itself
db2 = foldl (\acc str -> addToDB acc str) db1 ["Add", "some", "more"]
db2str = printDB db2
--      ::: 1111000000100110010010111110001 --db1str
--      ::: 1111000101100110010010111110101 --db2str