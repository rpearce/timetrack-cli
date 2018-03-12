module Lib
    ( timeTrack
    ) where


import qualified Data.Foldable       as F
import           Data.Monoid
import qualified Options.Applicative as O
import           System.IO

import           ListEntries


data Command =
    Ls
    deriving (Show)


data Entry = Entry
    { index   :: Integer
    , date    :: String
    , message :: String
    } deriving (Show)


parser :: O.Parser Command
parser = (O.subparser . F.foldMap command)
    [ ("ls", "List entries", pure Ls)
    ]


info :: O.Parser a -> String -> O.ParserInfo a
info p desc = O.info
    (O.helper <*> p)
    (O.fullDesc
        <> O.progDesc desc
        <> O.header "timetrack-cli – Keep track of your working hours in plain text files."
    )


command :: (String, String, O.Parser Command) -> O.Mod O.CommandFields Command
command (cmd, desc, p) =
    O.command cmd (info p desc)


entryParser :: O.ParserInfo Command
entryParser =
    info parser "Interact with your timetrack-cli entries."


timeTrack = do
    result <- O.execParser entryParser
    case result of
        Ls -> putStrLn ListEntries
        _  -> putStrLn "NOPE"
