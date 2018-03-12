module ListEntries where

import           Control.Exception (try, tryJust)
import           Data.Maybe        (fromMaybe)
import           System.Directory  (getAppUserDataDirectory, doesFileExist)
import           System.IO
import           System.IO.Error   (isDoesNotExistError, isPermissionError)


{-blah fileRead =-}
{-    case fileRead of-}
{-        Left  err  -> err-}
{-        Right file -> fmap lines file-}


main = do
    path <- getAppUserDataDirectory "timetrack"
    fileExists <- doesFileExist path ++ "/timetrack.tx"

    if fileExists

    fileRead <- try (readFile $ path ++ "/timetrack.txt")
    return (blah fileRead)
