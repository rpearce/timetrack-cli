module Commands.Add
    ( add
    ) where


import           Data.List        (lines, unlines)
import           Entry
import           Helpers          (getFilePath, indentedOutput, loadLines)
import           System.Directory (removeFile, renameFile)
import           System.IO        (readFile)


-- @TODO: REFACTOR
add :: [String] -> IO String
add []              = return "No arguments provided.\nFor help: timetrack add --help"
add ["-h"]          = return "usage: timetrack add YYYY-MM-DD \"message\""
add ["--help"]      = return "usage: timetrack add YYYY-MM-DD \"message\""
add [_]             = return "Not enough arguments provided.\nFor help: timetrack add --help"
add [date, message] = do
    path <- getFilePath
    entries <- fmap parseLines loadLines
    let index = nextRowNum entries
        newEntry = Entry { index = index, date = date, message = message }
        updatedEntries = entries ++ [newEntry]
        tmpPath = path ++ ".tmp"
    writeFile tmpPath $ unlines $ fmap showOutput updatedEntries
    removeFile path
    renameFile tmpPath path
    let output = indentedOutput $ showEntry newEntry
    return $ "=> Wrote to " ++ path ++ "\n" ++ output
