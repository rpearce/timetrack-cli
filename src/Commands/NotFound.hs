module Commands.NotFound
    ( notFound
    ) where


notFound :: String -> String
notFound cmd =
    "No such command: " ++ cmd
