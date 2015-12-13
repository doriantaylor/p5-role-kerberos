package Role::Kerberos;

use 5.010;
use strict;
use warnings FATAL => 'all';

use Moo::Role;
use Authen::Krb5;
use Scalar::Util ();
use Carp         ();
use Try::Tiny    ();

# Authen::Krb5 contains a global, presumably non-threadsafe pointer to
# this execution context. This is the best way I can muster dealing
# with it.

BEGIN {
    Authen::Krb5::init_context();
}

END {
    Authen::Krb5::free_context();
}

sub _is_really {
    my ($x, $class) = @_;
    defined $x and ref $x and Scalar::Util::blessed($x) and $x->isa($class);
}

sub _k5err {
    Carp::croak(@_, ': ', Authen::Krb5::error());
}

=head1 NAME

Role::Kerberos - A role for managing Kerberos 5 credentials

=head1 VERSION

Version 0.01_01

=cut

our $VERSION = '0.01_01';

=head1 SYNOPSIS

  use Moo;
  with 'Role::Kerberos';

  # go nuts

=head1 DESCRIPTION

L<Authen::Krb5> is kind of unwieldy. L<Authen::Krb5::Simple> is too
simple (no keytabs). L<Authen::Krb5::Effortless> requires too much
effort (can't specify keytabs/ccaches outside of environment
variables) and L<Authen::Krb5::Easy> hasn't been touched in 13 years.

The purpose of this module is to enable you to strap Kerberos onto an
existing (L<Moo>[L<se|Moose>]) object.

=head1 METHODS

=head2 new

=head3 Parameters/Accessors

=over 4

=item realm

The default realm.

=cut

has realm => (
);

=item principal

The default principal.

=cut

has principal => (
);

=item keytab

A keytab, if other than C<$ENV{KRB5_KTNAME}>.

=cut

has keytab => (
);

=item ccache

The locator (e.g. file path) of a credential cache.

=cut

has ccache => (
);

=back

=head2 kinit %PARAMS

Log in to Kerberos. Parameters are optional

=over 4

=item principal

=item realm

=item password

=item keytab

=back

=cut

sub kinit {
}

=head2 klist %PARAMS

=cut

sub klist {
}

=head2 kdestroy

=cut

sub kdestroy {
}

=head1 AUTHOR

Dorian Taylor, C<< <dorian at cpan.org> >>

=head1 SEE ALSO

=over 4

=item L<Authen::Krb5>

=item L<Moo::Role>

=back


=head1 BUGS

Please report any bugs or feature requests to C<bug-role-kerberos at
rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Role-Kerberos>.  I
will be notified, and then you'll automatically be notified of
progress on your bug as I make changes.

=head1 LICENSE AND COPYRIGHT

Copyright 2015 Dorian Taylor.

Licensed under the Apache License, Version 2.0 (the "License"); you
may not use this file except in compliance with the License.  You may
obtain a copy of the License at
L<http://www.apache.org/licenses/LICENSE-2.0>.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied.  See the License for the specific language governing
permissions and limitations under the License.

=cut

1; # End of Role::Kerberos
