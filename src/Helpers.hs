module Helpers
    ( getFilePath
    , indentedOutput
    , loadLines
    ) where


import           Data.List        (lines, unlines)
import           System.Directory (getAppUserDataDirectory)


getFilePath :: IO FilePath
getFilePath =
    fmap (++ "/timetrack.txt") (getAppUserDataDirectory "timetrack")


loadLines :: IO [String]
loadLines =
    fmap lines (getFilePath >>= readFile)


indentedOutput :: String -> String
indentedOutput =
    (++) "   ├── "
