module Helpers
    ( getFilePath
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


indentedOutput :: String -> String
indentedOutput str =
    "   ├── " ++ str
