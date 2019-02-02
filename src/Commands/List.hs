module Commands.List
    ( ls
    ) where


import qualified Entry   as E
import           Helpers (getFilePath, loadLines)


ls :: [String] -> IO String
ls ["-s"]    = handleSum
ls ["--sum"] = handleSum
ls _         = handleLs


handleLs :: IO String
handleLs =
    fmap linesToString getLines


handleSum :: IO String
handleSum =
  fmap sumLines getLines


-- HELPERS


getLines :: IO [String]
getLines =
    loadLines =<< getFilePath


linesToString :: [String] -> String
linesToString =
    unlines . E.showEntriesWithIndex . fmap E.parse


sumLines :: [String] -> String
sumLines =
    show . sum . fmap (E.parseAmount . E.parse)
