# timetrack-cli
WORK IN PROGRESS

## Plan
The idea is that you can use the command line to keep track of your working hours in plain text files, similar to https://github.com/ginatrapani/todo.txt-cli.

These files would be broken down by context:
* timetrack-current.txt (time tracking periods from today)
* timetrack-done.txt (time tracking periods from the latest grouping [think pay-period])
* timetrack-archive.txt (historical archive of trackings)

## Output
What would this look like? While I'd like this to have a lot of functionality at some point, let's keep this simple.
```
1..2017-06-01..mailers, tests and bug fixes for @company1 +03:30
2..2017-06-02..@company2: searching functionality +08:00
```
The date auto-sets (optional override?) and you use free text to type out the work, where `@company` or `@anything` tracks a context and `+03:30` tracks an amount of time worked. The goal with this would be to specify a start and end date, a @context and then have that add up all the hours.

## CLI
### List entries
```
$ tt ls
1..2017-06-01..mailers, tests and bug fixes for @company1 +03:30
2..2017-06-02..@company2: searching functionality +08:00
```

### Adding a new entry
```
$ tt add 2017-12-25 "extracted JSON decoders – @elmcompany +02:00"
=> Wrote to my-file.txt:
   ├── 12..2017-06-03..extracted JSON decoders to separate file – @elmcompany +02:00
```

### Editing an entry (WIP)
```
$ tt edit 12 2017-06-03 "did some decoding work +02:00"
=> Edited to my-file.txt:
   ├── 12..2017-06-03..did some decoding work +02:00
```

### Removing an entry timetrack-cli (WIP)
```
$ tt remove 12
=> Removed from my-file.txt:
   ├── 12..2017-06-03..extracted JSON decoders to separate file – @elmcompany +02:00
```
