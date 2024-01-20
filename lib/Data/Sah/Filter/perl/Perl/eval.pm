package Data::Sah::Filter::perl::Perl::eval;

use 5.010001;
use strict;
use warnings;

use Data::Dmp;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    +{
        v => 1,
        summary => 'Evaluate a coderef, fail the filter if coderef does not return true',
        description => <<'_',

WARNING: This filter allows specifying arbitrary Perl code.

_
        might_fail => 0,
        args => {
            code => {schema=>'code*', req=>1},
        },
        examples => [
        ],
    };
}

sub filter {
    my %fargs = @_;

    my $dt = $fargs{data_term};
    my $gen_args = $fargs{args} // {};

    my $res = {};
    $res->{expr_filter} = join(
        "",
        "do { ", (
            "my \$tmp = $dt; my \$from_pat = ", dmp($gen_args->{from_pat}), "; my \$to_str = ", dmp($gen_args->{to_str}), "; ",
            "\$tmp =~ s/\$from_pat/\$to_str/g; ",
            "\$tmp ",
        ), "}",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|filter)$

=head1 SEE ALSO
