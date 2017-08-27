module Lib
    ( timeTrack
    ) where

import System.IO
import System.Directory
import System.Environment (getArgs)
{-import Data.List.Split (splitOn)-}
{-import Data.Time-}

timeTrack :: IO ()
timeTrack = do
    args <- getArgs
    case args of
        ["add", date, text] -> add date text
        ["remove", n]       -> putStrLn $ "Remove line " ++ n ++ " (COMING SOON)"
        ["ls"]              -> ls
        otherwise           -> putStrLn "Please either use `add` or `remove`"

filePath :: String
filePath = "/Users/rpearce/Dropbox/hours.txt"

add :: String -> String -> IO ()
add date text = do
    rows <- readLines filePath
    let
        tmpFilePath = filePath ++ ".tmp"
        newLine = show (nextRowNum rows) ++ ".." ++ date ++ ".." ++ text
        updatedRows = rows ++ [newLine]

    writeFile tmpFilePath $ unlines updatedRows
    removeFile filePath
    renameFile tmpFilePath filePath
    putStrLn $ "=> Wrote to " ++ filePath
    putStrLn $ indentedOutput newLine

ls :: IO ()
ls = do
    rows <- readLines filePath
    putStrLn $ unlines rows

readLines :: FilePath -> IO [String]
readLines =
    fmap lines . readFile

nextRowNum :: [String] -> Integer
nextRowNum =
    inc . fromIntegral . length

inc :: Integer -> Integer
inc n =
    n + 1

indentedOutput :: String -> String
indentedOutput str =
    "   ├──" ++ str
