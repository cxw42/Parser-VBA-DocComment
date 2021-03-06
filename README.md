# Parser::VBA::DocComment - Extract documentation comments from Visual Basic for Applications source files



See ["extract"](#extract).

# EXPORT

Nothing by default; `:all` for everything; otherwise, any of the functions
listed below.

# FUNCTIONS

## extract

Extract comments.  Usage:

    my $comment_arrayref = Parser::VBA::DocComment::extract($source);

`$source` is anything that can be passed to the `io_from_any` function
in [IO::Handle::Util](https://metacpan.org/pod/IO::Handle::Util).

# BUGS

Please report any bugs or feature requests through the web interface at
[https://github.com/cxw42/Parser-VBA-DocComment/issues](https://github.com/cxw42/Parser-VBA-DocComment/issues).  I will be notified, and
then you'll automatically be notified of progress on your bug as I make
changes.

# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Parser::VBA::DocComment

You can also look for information at:

- GitHub (main repository)

    [https://github.com/cxw42/Parser-VBA-DocComment](https://github.com/cxw42/Parser-VBA-DocComment)

- MetaCPAN

    [https://metacpan.org/release/Parser-VBA-DocComment](https://metacpan.org/release/Parser-VBA-DocComment)

- CPAN Ratings

    [https://cpanratings.perl.org/d/Parser-VBA-DocComment](https://cpanratings.perl.org/d/Parser-VBA-DocComment)

# LICENSE

Copyright 2019 Christopher White.  This module is free software; you can
redistribute it and/or modify it under the same terms as Perl itself.
This software is provided with NO WARRANTY.
