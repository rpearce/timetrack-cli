module Commands.Add
    ( add
    ) where


import           Data.List        (lines, unlines)
import           Entry
import           Helpers          (getFilePath, indentedOutput, loadEntries,
                                   nextRowNum, parseEntries, showOutput)
import           System.Directory (removeFile, renameFile)
import           System.IO        (readFile)


add :: [String] -> IO ()
add []              = putStrLn "No arguments provided.\nFor help: timetrack add --help"
add ["-h"]          = putStrLn "usage: timetrack add YYYY-MM-DD \"message\""
add ["--help"]      = putStrLn "usage: timetrack add YYYY-MM-DD \"message\""
add [_]             = putStrLn "Not enough arguments provided.\nFor help: timetrack add --help"
add [date, message] = do
    path <- getFilePath
    loadedLines <- loadEntries
    let entries = parseEntries loadedLines
        index = nextRowNum entries
        newEntry = Entry { index = index, date = date, message = message }
        updatedEntries = entries ++ [newEntry]
        tmpPath = path ++ ".tmp"
    writeFile tmpPath $ unlines $ fmap showOutput updatedEntries
    removeFile path
    renameFile tmpPath path
    putStrLn $ "=> Wrote to " ++ path
    putStrLn $ indentedOutput $ show newEntry
