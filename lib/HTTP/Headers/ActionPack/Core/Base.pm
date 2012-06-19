package HTTP::Headers::ActionPack::Core::Base;
BEGIN {
  $HTTP::Headers::ActionPack::Core::Base::AUTHORITY = 'cpan:STEVAN';
}
{
  $HTTP::Headers::ActionPack::Core::Base::VERSION = '0.03';
}
# ABSTRACT: A Base class

use strict;
use warnings;

use overload '""' => 'as_string', fallback => 1;

sub new {
    my $class = shift;
    my $self  = $class->CREATE( $class->BUILDARGS( @_ ) );
    $self->BUILD( @_ );
    $self;
}

sub BUILDARGS { +{ ref $_[0] eq 'HASH' ? %{ $_[0] } : @_ } }

sub CREATE {
    my ($class, $instance) = @_;
    bless $instance => $class;
}

sub BUILD {}

sub as_string {
    my $self = shift;
    "$self"
}

1;



=pod

=head1 NAME

HTTP::Headers::ActionPack::Core::Base - A Base class

=head1 VERSION

version 0.03

=head1 SYNOPSIS

  use HTTP::Headers::ActionPack::Core::Base;

=head1 DESCRIPTION

There is no real user servicable parts in here.

=head1 METHODS

=item C<new>

=item C<BUILDARGS>

=item C<CREATE>

=item C<BUILD>

=item C<as_string>

=back

=head1 AUTHOR

Stevan Little <stevan.little@iinteractive.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Infinity Interactive, Inc..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

