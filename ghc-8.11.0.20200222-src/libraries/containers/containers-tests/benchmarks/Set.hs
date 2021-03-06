{-# LANGUAGE BangPatterns #-}

module Main where

import Control.DeepSeq (rnf)
import Control.Exception (evaluate)
import Gauge (bench, defaultMain, whnf)
import Data.List (foldl')
import qualified Data.Set as S

main = do
    let s = S.fromAscList elems :: S.Set Int
        s_even = S.fromAscList elems_even :: S.Set Int
        s_odd = S.fromAscList elems_odd :: S.Set Int
    evaluate $ rnf [s, s_even, s_odd]
    defaultMain
        [ bench "member" $ whnf (member elems) s
        , bench "insert" $ whnf (ins elems) S.empty
        , bench "map" $ whnf (S.map (+ 1)) s
        , bench "filter" $ whnf (S.filter ((== 0) . (`mod` 2))) s
        , bench "partition" $ whnf (S.partition ((== 0) . (`mod` 2))) s
        , bench "fold" $ whnf (S.fold (:) []) s
        , bench "delete" $ whnf (del elems) s
        , bench "findMin" $ whnf S.findMin s
        , bench "findMax" $ whnf S.findMax s
        , bench "deleteMin" $ whnf S.deleteMin s
        , bench "deleteMax" $ whnf S.deleteMax s
        , bench "unions" $ whnf S.unions [s_even, s_odd]
        , bench "union" $ whnf (S.union s_even) s_odd
        , bench "difference" $ whnf (S.difference s) s_even
        , bench "intersection" $ whnf (S.intersection s) s_even
        , bench "fromList" $ whnf S.fromList elems
        , bench "fromList-desc" $ whnf S.fromList (reverse elems)
        , bench "fromAscList" $ whnf S.fromAscList elems
        , bench "fromDistinctAscList" $ whnf S.fromDistinctAscList elems
        , bench "disjoint:false" $ whnf (S.disjoint s) s_even
        , bench "disjoint:true" $ whnf (S.disjoint s_odd) s_even
        , bench "null.intersection:false" $ whnf (S.null. S.intersection s) s_even
        , bench "null.intersection:true" $ whnf (S.null. S.intersection s_odd) s_even
        ]
  where
    elems = [1..2^12]
    elems_even = [2,4..2^12]
    elems_odd = [1,3..2^12]

member :: [Int] -> S.Set Int -> Int
member xs s = foldl' (\n x -> if S.member x s then n + 1 else n) 0 xs

ins :: [Int] -> S.Set Int -> S.Set Int
ins xs s0 = foldl' (\s a -> S.insert a s) s0 xs

del :: [Int] -> S.Set Int -> S.Set Int
del xs s0 = foldl' (\s k -> S.delete k s) s0 xs
