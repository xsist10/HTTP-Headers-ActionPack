package HTTP::Headers::ActionPack::Core::BaseHeaderWithParams;
BEGIN {
  $HTTP::Headers::ActionPack::Core::BaseHeaderWithParams::AUTHORITY = 'cpan:STEVAN';
}
{
  $HTTP::Headers::ActionPack::Core::BaseHeaderWithParams::VERSION = '0.04';
}
# ABSTRACT: A Base header type with params

use strict;
use warnings;

use Carp qw[ confess ];

use parent 'HTTP::Headers::ActionPack::Core::Base';

# NOTE:
# this is meant to be
# called by subclasses
# in their BUILDARGS
# methods
# - SL
sub _prepare_params {
    my ($class, @params) = @_;

    confess "Params must be an even sized list" unless (((scalar @params) % 2) == 0);

    my @param_order;
    for ( my $i = 0; $i < $#params; $i += 2 ) {
        push @param_order => $params[ $i ];
    }

    return +{
        params      => { @params },
        param_order => \@param_order
    };
}

sub params       { (shift)->{'params'}      }
sub _param_order { (shift)->{'param_order'} }

sub add_param {
    my ($self, $k, $v) = @_;
    $self->params->{ $k } = $v;
    push @{ $self->_param_order } => $k;
}

sub remove_param {
    my ($self, $k) = @_;
    $self->{'param_order'} = [ grep { $_ ne $k } @{ $self->{'param_order'} } ];
    return delete $self->params->{ $k };
}

sub params_in_order {
    my $self = shift;
    map { $_, $self->params->{ $_ } } @{ $self->_param_order }
}

sub params_are_empty {
    my $self = shift;
    (scalar keys %{ $self->params }) == 0 ? 1 : 0
}

1;

__END__

=pod

=head1 NAME

HTTP::Headers::ActionPack::Core::BaseHeaderWithParams - A Base header type with params

=head1 VERSION

version 0.04

=head1 SYNOPSIS

  use HTTP::Headers::ActionPack::Core::BaseHeaderWithParams;

=head1 DESCRIPTION

This is a base class for header values which contain
a parameter list. There is no real user servicable parts
in here.

=head1 METHODS

=over 4

=item C<params>

Accessor for the unordered hash-ref of params.

=item C<add_param( $key, $value )>

Add in a parameter, it will be placed at end
very end of the parameter order.

=item C<remove_param( $key )>

Remove a parameter from the link.

=item C<params_are_empty>

Returns false if there are no parameters on the invovant.

=back

=head1 AUTHOR

Stevan Little <stevan.little@iinteractive.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Infinity Interactive, Inc..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
