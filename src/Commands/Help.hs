module Commands.Help
    ( help
    ) where


help :: String
help =
    "usage: timetrack <command>\n\n" ++
        "  add   Add entry\n" ++
        "  dir   Print timetrack directory\n" ++
        "  ls    List entries\n" ++
        "  rm    Remove entry"
