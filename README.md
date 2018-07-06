# timetrack-cli
WORK IN PROGRESS.

## Plan
The idea is that you can use the command line to keep track of your working
hours in plain text files, similar to
https://github.com/ginatrapani/todo.txt-cli.

These files would be broken into current and archive files:
* `$XDG_DATA_HOME/timetrack/timetrack.txt`: time tracking periods from the latest grouping (think pay-period)
* `$XDG_DATA_HOME/timetrack/timetrack.old.txt`: historical archive of trackings

Here's what the file contents look like:

```txt
2017-06-01 mailers, tests and bug fixes for @company1 +3.5
2017-06-02 @company2: searching functionality +8.0
```

This allows us to keep track of work done in specific contexts, programmatically
sum the hours worked in total (for said company or otherwise) and do so between
dates.

Example problem statement:

> I need to add up all the hours I worked for Company X between these two dates
and list them out and/or copy to clipboard (pipe to `pbcopy`).

## CLI
I find it helpful to alias `timetrack` to `tt` for ease of use. If you'd like to
do the same, place the following in your `.bash_profile`, `.bashrc` or wherever
that gets included in your terminal session.
```
alias tt="timetrack"
```

### List entries
```
$ tt ls
01  2017-06-01  mailers, tests and bug fixes for @company1 +3.5
02  2017-06-02  @company2: searching functionality +8.0
```

### Adding a new entry
```
$ tt add 2017-12-25 "extracted JSON decoders – @elmcompany +2.0"
=> Wrote to $XDG_DATA_HOME/timetrack/timetrack.txt:
   ├── 12  2017-06-03  extracted JSON decoders to separate file – @elmcompany +2.0
```

#### ARGUMENTS
* Date: `YYYY-MM-DD` format
* Message: `"text"` format
  * Hint: Use `@tag` for grouping tags/contexts and `+float` (e.g., `+4.5`) to add time

### Removing an entry
Remove an entry by a line number
```
$ tt ls
01  2017-06-01  mailers, tests and bug fixes for @company1 +3.5
02  2017-06-02  @company2: searching functionality +8.0

$ tt rm 2
=> Removed from $XDG_DATA_HOME/timetrack/timetrack.txt:
   ├── 02  2017-06-02  @company2: searching functionality +8.0
```

### Update an entry
```
$ tt ls
01  2017-06-01  mailers, tests and bug fixes for @company1 +3.5
02  2017-06-02  research and prototyping for @company3 +4.0
03  2017-06-03  @company2: searching functionality +8.0

$ tt update 2 2017-06-04 "meetings and more for @company3 +7.5"
=> Updated in $XDG_DATA_HOME/timetrack/timetrack.txt:
  (from) ├── 02  2017-06-02  research and prototyping for @company3 +4.0
    (to) ├── 03  2017-06-04  meetings and more for @company3 +7.5
```

#### ARGUMENTS
* Line number
* Date: `YYYY-MM-DD` format
* Message: `"text"` format

### Display Output File Directory
```
$ tt dir
$XDG_DATA_HOME/timetrack/
```

### Display Stats Info
This is an expanding concept for `ls`, but the idea would be to display
analyses of data when requested. These could be sums, stats, whatever.

#### OPTIONS
* `-t`, `--tag`

   Filter info results by `@tag`

* `-d`, `--date` (or something...)

   Filter info results by date(s).

## Dev
1. need to have [the Haskell stack tool](https://docs.haskellstack.org/en/stable/README/)
1. Edit code in `src/` directory
1. run `$ stack build --pedantic --copy-bins` to get a binary copied to `/usr/.local/bin`
1. use the CLI
