module Commands.List
    ( ls
    ) where


import           Helpers (loadEntries, parseEntries, printEntries)


ls :: [String] -> IO ()
ls _ = do
    loadedLines <- loadEntries
    putStrLn "#  Date        Description"
    putStrLn "-  ----------  -----------"
    printEntries $ parseEntries loadedLines
