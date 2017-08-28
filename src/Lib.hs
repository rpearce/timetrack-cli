module Lib
    ( timeTrack
    ) where

import System.IO
import System.Directory (removeFile, renameFile)
import System.Environment (getArgs, lookupEnv)
import Data.Maybe (fromMaybe)
{-import Data.List.Split (splitOn)-}
{-import Data.Time-}

timeTrack :: IO ()
timeTrack = do
    args <- getArgs
    case args of
        ["add", date, text] -> add date text
        ["rm", n]           -> putStrLn $ "Remove line " ++ n ++ " (COMING SOON)"
        ["ls"]              -> ls
        otherwise           -> putStrLn "Please either use `add`, `rm` or `ls`"

defaultPath :: String
defaultPath =
    "/Users/rpearce/Dropbox/timetrack.txt"

add :: String -> String -> IO ()
add date text = do
    filePath <- fromMaybe defaultPath <$> lookupEnv "TIMETRACK_PATH"
    rows <- readLines filePath
    let
        tmpFilePath :: String
        tmpFilePath = filePath ++ ".tmp"

        newLine :: String
        newLine = show (nextRowNum rows) ++ ".." ++ date ++ ".." ++ text

        updatedRows :: [String]
        updatedRows = rows ++ [newLine]

    writeFile tmpFilePath $ unlines updatedRows
    removeFile filePath
    renameFile tmpFilePath filePath
    putStrLn $ "=> Wrote to " ++ filePath
    putStrLn $ indentedOutput newLine

ls :: IO ()
ls = do
    filePath <- fromMaybe defaultPath <$> lookupEnv "TIMETRACK_PATH"
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
    "   ├── " ++ str
