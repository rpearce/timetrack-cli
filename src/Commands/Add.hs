module Commands.Add
    ( add
    ) where


import           Data.List (lines, unlines)
import qualified Entry     as E
import           Helpers   (getFilePath, indentedOutput, updateFileContent)
import           System.IO (readFile)


add :: [String] -> IO String
add []              = return "No arguments provided.\nFor help: timetrack add --help"
add ["-h"]          = return "usage: timetrack add YYYY-MM-DD \"message\""
add ["--help"]      = return "usage: timetrack add YYYY-MM-DD \"message\""
add [_]             = return "Not enough arguments provided.\nFor help: timetrack add --help"
add [date, message] = do
    path <- getFilePath
    entries <- E.loadEntries path

    let newEntry = E.Entry { E.date = date, E.message = message }
        updatedEntries = E.sortByDate (entries ++ [newEntry])
        idx = E.position newEntry updatedEntries
        output = fmap E.outputEntry updatedEntries

    updateFileContent path (unlines output)

    return $ "=> Wrote to "
        ++ path
        ++ "\n"
        ++ indentedOutput (E.showEntryWithIndex idx newEntry)
