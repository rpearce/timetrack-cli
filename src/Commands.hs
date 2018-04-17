module Commands
    ( add
    , ls
    ) where


import           Data.List        (lines, unlines)
import           System.Directory (getAppUserDataDirectory, removeFile,
                                   renameFile)
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


getFilePath :: IO FilePath
getFilePath = do
    path <- getAppUserDataDirectory "timetrack"
    return $ path ++ "/timetrack.txt"


loadEntries :: IO [String]
loadEntries = do
    path <- getFilePath
    contents <- readFile path
    return $ lines contents


parseEntries :: [String] -> [Entry]
parseEntries =
    zipWith parseEntry [1..]


parseEntry :: Integer -> String -> Entry
parseEntry n line =
    let
        (date, rest) = splitAt 10 line
        message = drop 1 rest
    in
        Entry { index = n, date = date, message = message }


printEntries :: [Entry] -> IO ()
printEntries =
    putStrLn . unlines . fmap show


indentedOutput :: String -> String
indentedOutput str =
    "   ├── " ++ str


inc :: Integer -> Integer
inc =
    (+1)


nextRowNum :: [Entry] -> Integer
nextRowNum =
    inc . fromIntegral . length


showOutput :: Entry -> String
showOutput entry =
    date entry ++ " " ++ message entry



-- ADD


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


-- LIST


ls :: [String] -> IO ()
ls _ = do
    loadedLines <- loadEntries
    putStrLn "#  Date        Description"
    putStrLn "-  ----------  -----------"
    printEntries $ parseEntries loadedLines
