module Helpers
    ( dropK
    , getDirPath
    , getFilePath
    , indentedOutput
    , loadLines
    , mConst
    , updateFileContent
    ) where


import           System.Directory (XdgDirectory (XdgData), getXdgDirectory,
                                   removeFile, renameFile)


dropK :: Int -> [a] -> [a]
dropK k ks =
    take k ks ++ drop (k + 1) ks


getDirPath :: IO FilePath
getDirPath =
    getXdgDirectory XdgData "timetrack"


getFilePath :: IO FilePath
getFilePath =
    fmap (++ "/timetrack.txt") getDirPath


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
