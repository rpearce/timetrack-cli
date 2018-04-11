module Commands
    ( add
    , ls
    ) where


import           Data.List        (lines, unlines)
import           System.Directory (getAppUserDataDirectory)
import           System.IO        (readFile)


-- ADD


add :: [String] -> IO ()
add []              = putStrLn "No arguments provided.\nFor help: timetrack add --help"
add ["-h"]          = putStrLn "usage: timetrack add YYYY-MM-DD \"message\""
add ["--help"]      = putStrLn "usage: timetrack add YYYY-MM-DD \"message\""
add [_]             = putStrLn "Not enough arguments provided.\nFor help: timetrack add --help"
add [date, message] = do
    putStrLn date
    putStrLn message


-- LIST


ls :: [String] -> IO ()
ls _ = do
    path <- getAppUserDataDirectory "timetrack"
    contents <- readFile $ path ++ "/timetrack.txt"
    putStrLn "#  Date        Description"
    putStrLn "-  ----------  -----------"
    putStr $ handleLs contents


handleLs :: String -> String
handleLs =
    unlines . buildEntries . lines


buildEntries :: [String] -> [String]
buildEntries =
    zipWith buildEntry [1..]


buildEntry :: Integer -> String -> String
buildEntry n entry =
    let
        (date, rest) = splitAt 10 entry
        content = drop 1 rest
    in
        show n ++ "  " ++ date ++ "  " ++ content
