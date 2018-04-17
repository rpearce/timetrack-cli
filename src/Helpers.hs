module Helpers
    ( getFilePath
    , inc
    , indentedOutput
    , loadEntries
    , nextRowNum
    , parseEntries
    , parseEntry
    , printEntries
    , showOutput
    ) where


import           Data.List        (lines, unlines)
import           Entry
import           System.Directory (getAppUserDataDirectory)
import           System.IO        (readFile)


getFilePath :: IO FilePath
getFilePath = do
    path <- getAppUserDataDirectory "timetrack"
    return $ path ++ "/timetrack.txt"


inc :: Integer -> Integer
inc =
    (+1)


indentedOutput :: String -> String
indentedOutput str =
    "   ├── " ++ str


nextRowNum :: [Entry] -> Integer
nextRowNum =
    inc . fromIntegral . length


loadEntries :: IO [String]
loadEntries = do
    path <- getFilePath
    contents <- readFile path
    return $ lines contents


parseEntries :: [String] -> [Entry]
parseEntries =
    zipWith parseEntry [1..]


parseEntry :: Integer -> String -> Entry
parseEntry n line =
    let
        (date, rest) = splitAt 10 line
        message = drop 1 rest
    in
        Entry { index = n, date = date, message = message }


printEntries :: [Entry] -> IO ()
printEntries =
    putStrLn . unlines . fmap show


showOutput :: Entry -> String
showOutput entry =
    date entry ++ " " ++ message entry
