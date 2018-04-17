module Entry
    ( Entry(..)
    ) where


data Entry = Entry
    { index   :: Integer
    , date    :: String
    , message :: String
    }


instance Show Entry where
    show (Entry index entry message) =
        show index ++ "  " ++ entry ++ "  " ++ message
