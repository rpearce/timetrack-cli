module Commands
    ( add
    , ls
    ) where


import           Data.List        (lines, unlines)
import           System.Directory (getAppUserDataDirectory)
import           System.IO        (readFile)


data Entry = Entry
    { index   :: Integer
    , date    :: String
    , message :: String
    }


instance Show Entry where
    show (Entry index entry message) =
        show index ++ "  " ++ entry ++ "  " ++ message


-- HELPERS


loadEntries :: IO [String]
loadEntries = do
    path <- getAppUserDataDirectory "timetrack"
    contents <- readFile $ path ++ "/timetrack.txt"
    return $ lines contents


parseEntries :: [String] -> [Entry]
parseEntries =
    zipWith parseEntry [1..]


parseEntry :: Integer -> String -> Entry
parseEntry n entry =
    let
        (date, rest) = splitAt 10 entry
        message = drop 1 rest
    in
        Entry { index = n, date = date, message = message }


printEntries :: [Entry] -> IO ()
printEntries =
    putStrLn . unlines . map show


-- ADD


add :: [String] -> IO ()
add []              = putStrLn "No arguments provided.\nFor help: timetrack add --help"
add ["-h"]          = putStrLn "usage: timetrack add YYYY-MM-DD \"message\""
add ["--help"]      = putStrLn "usage: timetrack add YYYY-MM-DD \"message\""
add [_]             = putStrLn "Not enough arguments provided.\nFor help: timetrack add --help"
add [date, message] = do
    loadedLines <- loadEntries
    let entries = parseEntries loadedLines
        index = fromIntegral $ length entries
        newEntry = Entry { index = index + 1, date = date, message = message }
    printEntries $ entries ++ [newEntry]


-- LIST


ls :: [String] -> IO ()
ls _ = do
    loadedLines <- loadEntries
    putStrLn "#  Date        Description"
    putStrLn "-  ----------  -----------"
    printEntries $ parseEntries loadedLines
