# fixnames

Fix filenames to be bash-script safe and easy to type.

## Usage

ee the {Fixnames::Option} for the various settings.

``` sh
    fixnames [options] <files>
    fixdirs [options] <directories>
```    

### examples

cleanup a dir:

``` sh
    fixnames -fvv somedir/*
```

Remove all "`xyzzy`" from filenames:

``` sh
    fixnames -x xyzzy *
```

Remove all *digits* from filenames and replace them with "`X`":

``` sh
    fixnames -x \[0-9] -r X *
```

## Suggested Alias

I keep the actually changing of massive amounts of filenames
as something you must _requrest_ proactively. Higher levels of
verbosity are often essential, and the "-p" flag to _pretend_
to make changes at first cna save you from MASSIVE data loss.

I also include the `-f/--full` option to turn on all of the 
standard filters, which is the aggressive renaming I want to do,
but i's still probably a good idea tol leave it explicitly "opt-in".

Because of all of this, I usually run with this alias:

``` sh
    alias fn='fixnames -fvv'
```

With that I can use the fact that it auto-supplies `"./*"`
as what to work on means I can an entire directoy of bad
files with just `"fn"`.

## Fixdirs still unfinished

Recursive-descent into sub-dirs with `fixdirs` isn't really
finished yet. It might be a bit too much to have a command
that can wipe out an entire filesystem.

It should go
withoutsaying, you should **NEVER** use this stuff as *Root*!
It doesn't matter, though, as it's proving in practice
to be suficient easy to just do things directory-at-a-time.
with `fixnames` by itself.

## Copyright

Copyright (c) 2011 Brent Sanders. See LICENSE.txt for
further details.

