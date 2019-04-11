package Parser::VBA::DocComment;

use 5.014;
use strict;
use warnings;
use parent 'Exporter';

our $VERSION = '0.000001';  # TRIAL

our (@EXPORT, @EXPORT_OK, %EXPORT_TAGS);
BEGIN {
    @EXPORT = ();
    @EXPORT_OK = qw(extract);
    %EXPORT_TAGS = (
        default => [@EXPORT],
        all => [@EXPORT, @EXPORT_OK]
    );
}

use Carp qw(croak);
use Getargs::Mixed;
use IO::Handle;
use IO::Handle::Util qw(io_from_any);

# Docs =================================================================== {{{1

=head1 NAME

Parser::VBA::DocComment - Extract documentation comments from Visual Basic for Applications source files

=head1 SYNOPSIS

See L</extract>.

=head1 EXPORT

Nothing by default; C<:all> for everything; otherwise, any of the functions
listed below.

=head1 FUNCTIONS

=cut

# }}}1

=head2 extract

Extract comments.  Usage:

    my $comment_arrayref = Parser::VBA::DocComment::extract($source);

C<$source> is anything that can be passed to the C<io_from_any> function
in L<IO::Handle::Util>.

=cut

# States of the parser
use enum qw(:P_ WAITING COLLECTING);

sub extract {
    my %args = parameters([qw(source)], @_);

    # Get the data
    my $fh = io_from_any($args{source})
        or croak "I don't know how to read data from the given source";
    my $contents = do { local $/; <$fh> };
    return [] unless $contents;

    # Join lines
    $contents =~ s/\h+_\n//g;
    $fh = io_from_any(\$contents);

    # Parse
    my @retval;
    my $state = P_WAITING;
    my $comment;

    while(my $line = <$fh>) {
        my $have_doc_comment = ($line =~ /^\h*'''/);
        print "$.\t$line";
        if($state == P_WAITING && $have_doc_comment) {
            $line =~ s/^\h*'''\h*//;
            $comment = $line;
            $state = P_COLLECTING;

        } elsif($state == P_COLLECTING && $have_doc_comment) {
            $line =~ s/^\h*'''\h*//;
            $comment .= $line;

        } elsif($state == P_COLLECTING && !$have_doc_comment) {
            # Skip blank lines
            while(defined $line && $line !~ /\S/) {
                $line = <$fh>;
            }
            chomp $line;
            chomp $comment;
            push @retval, {$line => $comment};
            $state = P_WAITING;
        }
    }

    return \@retval;
} #extract

1; # End of Parser::VBA::DocComment
__END__

# Rest of docs =========================================================== {{{1

=head1 BUGS

Please report any bugs or feature requests through the web interface at
L<https://github.com/cxw42/Parser-VBA-DocComment/issues>.  I will be notified, and
then you'll automatically be notified of progress on your bug as I make
changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Parser::VBA::DocComment

You can also look for information at:

=over 4

=item * GitHub (main repository)

L<https://github.com/cxw42/Parser-VBA-DocComment>

=item * MetaCPAN

L<https://metacpan.org/release/Parser-VBA-DocComment>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/Parser-VBA-DocComment>

=back

=head1 LICENSE

Copyright 2019 Christopher White.  This module is free software; you can
redistribute it and/or modify it under the same terms as Perl itself.
This software is provided with NO WARRANTY.

=cut

# }}}1
# vi: set fdm=marker: #
