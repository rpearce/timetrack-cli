module Commands
    ( ls
    ) where


import           Data.List        (lines, unlines)
import           System.Directory (getAppUserDataDirectory)
import           System.IO        (readFile)


{- LIST -}


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
