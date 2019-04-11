#!perl
# Kit: Test kit
package MY::Kit;

use 5.014;
use strict;
use warnings;
#use Test::Exception ();
#use Test::Fatal ();
use Test::More ();

use Import::Into;

sub import {
    my $target = caller;
    $_->import::into($target) foreach
        qw(strict warnings Test::More);
            # Test::Exception Test::Fatal
} #import()

1;
