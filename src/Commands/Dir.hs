module Commands.Dir
    ( dir
    ) where


import           Helpers (getDirPath)


dir :: [String] -> IO String
dir _ =
    getDirPath
