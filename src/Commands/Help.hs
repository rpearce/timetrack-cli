module Commands.Help
    ( help
    ) where


help :: String
help =
    "usage: timetrack <command>\n\n" ++
        "  add  Add entry\n" ++
        "  ls   List entries"
