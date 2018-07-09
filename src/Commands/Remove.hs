module Commands.Remove
    ( rm
    ) where


import qualified Entry     as E
import           Helpers   (getFilePath, indentedOutput, updateFileContent)
import           Text.Read (readMaybe)


forHelp :: String
forHelp =
    "For help: timetrack rm --help"


noArgs :: String
noArgs =
    "No arguments provided.\n" ++ forHelp


lineNotFound :: String
lineNotFound =
    "Line not found.\n" ++ forHelp


usage :: String
usage =
    "Usage: timetrack rm <LINE NUMBER>"


validLineNum :: String
validLineNum =
    "Invalid line number provided.\n" ++ forHelp


rm :: [String] -> IO String
rm []         = return noArgs
rm ["-h"]     = return usage
rm ["--help"] = return usage
rm [n]        = handleRm n
rm _          = return usage


handleRm :: String -> IO String
handleRm n = do
    path <- getFilePath
    entries <- E.loadEntries path
    let maybeN = readMaybe n :: Maybe Int
    performOrInvalid (path, maybeN, zip [1..] entries)


performOrInvalid :: (FilePath, Maybe Int, [(Int, E.Entry)]) -> IO String
performOrInvalid (_, Nothing, _) = return usage
performOrInvalid (path, Just n, xs)
    | n > 0 && n < length xs + 1 = perform (path, n, xs)
    | otherwise = return validLineNum


perform :: (FilePath, Int, [(Int, E.Entry)]) -> IO String
perform (path, n, xs) = do
    let maybeEntry = lookup n xs
    case maybeEntry of
        Nothing -> return lineNotFound
        Just entry -> do
            let updatedEntries = [y | y <- xs, fst y /= n]
                output = fmap (E.outputEntry . snd) updatedEntries

            _ <- updateFileContent path (unlines output)

            return $ "=> Removed from "
                ++ path
                ++ "\n"
                ++ indentedOutput (E.showEntryWithIndex (fromIntegral n) entry)
