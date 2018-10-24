module Commands.Add
    ( add
    ) where


import qualified Entry   as E
import           Helpers (getFilePath, indentedOutput, updateFileContent)


moreArgs :: String
moreArgs =
    "Not enough arguments provided.\nFor help: timetrack add --help"


noArgs :: String
noArgs =
    "No arguments provided.\nFor help: timetrack add --help"


usage :: String
usage =
    "Usage: timetrack add <YYYY-MM-DD> \"<MESSAGE>\""


add :: [String] -> IO String
add []              = return noArgs
add ["help"]        = return usage
add ["-h"]          = return usage
add ["--help"]      = return usage
add [_]             = return moreArgs
add [date, message] = handleAdd (date, message)
add _               = return usage


-- @TODO: safely do all this
handleAdd :: (String, String) -> IO String
handleAdd (date, message) = do
    path <- getFilePath
    entries <- E.loadEntries path

    let newEntry = E.Entry { E.date = date, E.message = message }
        updatedEntries = E.sortByDate (newEntry : entries)
        idx = E.position newEntry updatedEntries
        output = fmap E.outputEntry updatedEntries

    _ <- updateFileContent path (unlines output)

    return $ "=> Wrote to "
        ++ path
        ++ "\n"
        ++ indentedOutput (E.showEntryWithIndex idx newEntry)
