# timetrack-cli
WORK IN PROGRESS.

## Plan
The idea is that you can use the command line to keep track of your working hours in plain text files, similar to https://github.com/ginatrapani/todo.txt-cli.

These files would be broken into current and archive files:
* `timetrack.txt`: time tracking periods from the latest grouping (think pay-period)
* `timetrack-archive.txt`: historical archive of trackings

Here's what the output looks like (subject to slight change):

```txt
1  2017-06-01  "mailers, tests and bug fixes for @company1 +3.5"
2  2017-06-02  "@company2: searching functionality +8.0"
```

This allows us to keep track of work done in specific contexts, programmatically sum the hours worked in total (for said company or otherwise) and do so between dates.

Example problem statement:

> I need to add up all the hours I worked for Company X between these two dates and also list them out and/or copy to clipboard (`pbcopy`?).

## CLI
### List entries
```
$ tt ls
1  2017-06-01  "mailers, tests and bug fixes for @company1 +3.5"
2  2017-06-02  "@company2: searching functionality +8.0"
```

#### OPTIONS
* `-a`, `--all`

   List all entries; includes current and archived. Not required.

### Adding a new entry
```
$ tt add -d 2017-12-25 -m "extracted JSON decoders – @elmcompany +2.0"
=> Wrote to ~/timetrack/timetrack.txt:
   ├── 12  2017-06-03  "extracted JSON decoders to separate file – @elmcompany +2.0"
```

#### OPTIONS
* `-d`, `--date`

   YYYY-MM-DD format. Defaults to system date

* `-m`, `--message`

   Required. String that must be supplied to create an entry. Use `@tag` for grouping tags/contexts and `+float` (e.g., `+4.5`) to add time

### Removing an entry
```
$ tt ls
1  2017-06-01  "mailers, tests and bug fixes for @company1 +3.5"
2  2017-06-02  "@company2: searching functionality +8.0"

$ tt rm -n 2
=> Removed from ~/timetrack/timetrack.txt:
   ├── 2  2017-06-02  "@company2: searching functionality +8.0"
```

#### OPTIONS
* `-n`, `--line-number`

   Required. Remove an entry by a line number

### Update an entry
```
$ tt ls
1  2017-06-01  "mailers, tests and bug fixes for @company1 +3.5"
2  2017-06-02  "research and prototyping for @company3 +4.0"
3  2017-06-03  "@company2: searching functionality +8.0"

$ tt update -n 2 -d 2017-06-04 -m "meetings and more for @company3 +7.5"
=> Updated in ~/timetrack/timetrack.txt:
  (from) ├── 2  2017-06-02  "research and prototyping for @company3 +4.0"
    (to) ├── 3  2017-06-04  "meetings and more for @company3 +7.5"
```

#### OPTIONS
* `-n`, `--line-number`

   Required. Update an entry by a line number

* `-m`, `--message`

   String to replace an entry's message with

* `-d`, `--date`

   YYYY-MM-DD format. Date to replace an entry's date with

### Display Stats Info
This is an expanding concept, but the idea would be to display analyses of data when requested. These could be sums, stats, whatever.

#### OPTIONS
* `-t`, `--tag`

   Filter info results by `@tag`

* `-d`, `--date`

   YYYY-MM-DD YYYY-MM-DD. Filter info results by date(s). If two dates are provided, it will filter by the given range. If no second date is provided, use current system date.

## Dev
1. need to have [the Haskell stack tool](https://docs.haskellstack.org/en/stable/README/)
1. Edit code in `src/` directory
1. run `$ stack build --copy-bins` to get a binary copied to `/usr/.local/bin`
1. use the CLI
