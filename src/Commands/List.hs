module Commands.List
    ( ls
    ) where


import           Entry   (parse, showEntriesWithIndex)
import           Helpers (getFilePath, loadLines)


ls :: [String] -> IO String
ls _ =
    fmap linesToString (loadLines =<< getFilePath)


linesToString :: [String] -> String
linesToString =
    unlines . showEntriesWithIndex . fmap parse
