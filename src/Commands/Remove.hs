module Commands.Remove
    ( rm
    ) where


import qualified Entry     as E
import           Helpers   (dropK, getFilePath, indentedOutput,
                            updateFileContent)
import           Text.Read (readMaybe)


noArgs :: String
noArgs =
    "No arguments provided.\nFor help: timetrack rm --help"


usage :: String
usage =
    "Usage: timetrack rm <LINE NUMBER>"


validLineNum :: String
validLineNum =
    "Invalid line number provided.\nFor help: timetrack rm --help"


rm :: [String] -> IO String
rm []         = return noArgs
rm ["-h"]     = return usage
rm ["--help"] = return usage
rm [x]        = handleRm x
rm _          = return usage


handleRm :: String -> IO String
handleRm x = do
    path <- getFilePath
    entries <- E.loadEntries path
    blah path (readMaybe x :: Maybe Int) entries


blah :: FilePath -> Maybe Int -> [E.Entry] -> IO String
blah _ Nothing _ = return usage
blah path (Just n) xs
    | n > 0 && n < length xs + 1 = doIt path n xs
    | otherwise = return validLineNum


doIt :: FilePath -> Int -> [E.Entry] -> IO String
doIt path n xs = do
    let entry = xs !! (n - 1)
        updatedEntries = dropK (n - 1) xs
        output = fmap E.outputEntry updatedEntries

    _ <- updateFileContent path (unlines output)

    return $ "=> Removed from "
        ++ path
        ++ "\n"
        ++ indentedOutput (E.showEntryWithIndex (fromIntegral n) entry)
