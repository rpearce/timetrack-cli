module Helpers
    ( getFilePath
    , inc
    , indentedOutput
    , loadLines
    ) where


import           Data.List        (lines, unlines)
import           System.Directory (getAppUserDataDirectory)


getFilePath :: IO FilePath
getFilePath = do
    path <- getAppUserDataDirectory "timetrack"
    return $ path ++ "/timetrack.txt"


loadLines :: IO [String]
loadLines = do
    path <- getFilePath
    contents <- readFile path
    return $ lines contents


inc :: Integer -> Integer
inc =
    (+1)


indentedOutput :: String -> String
indentedOutput str =
    "   ├── " ++ str
