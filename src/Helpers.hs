module Helpers
    ( getFilePath
    , indentedOutput
    , loadLines
    , mConst
    , updateFileContent
    ) where


import           Data.List        (lines, unlines)
import           System.Directory (XdgDirectory (XdgData), getXdgDirectory,
                                   removeFile, renameFile)


getFilePath :: IO FilePath
getFilePath =
    fmap (++ "/timetrack.txt") (getXdgDirectory XdgData "timetrack")


loadLines :: FilePath -> IO [String]
loadLines =
    fmap lines . readFile


indentedOutput :: String -> String
indentedOutput =
    (++) "   ├── "


mConst :: a -> b -> IO a
mConst =
    const . return


updateFileContent :: FilePath -> String -> IO (FilePath, String)
updateFileContent path content = do
    let tmpPath = path ++ ".tmp"
    writeFile tmpPath content
    removeFile path
    renameFile tmpPath path
    return (path, content)
