# fixnames

Fix filenames to be bash-script safe and easy to type.

## Usage

  See the {Fixnames::Option} for the various settings.

    fixnames [options] <files>
    fixdirs [options] <directories>

### examples

cleanup a dir:
    fixnames -fvv somedir/*

Remove all "`xyzzy`" from filenames:
    fixnames -x xyzzy *

Remove all *digits* from filenames and replace them with "`X`":
    fixnames -x \[0-9] -r X *


## Copyright

Copyright (c) 2011 Brent Sanders. See LICENSE.txt for
further details.

