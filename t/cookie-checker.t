use strict;
use warnings;
use lib 'lib';

use Test::Mojo;
use Test::More;

my $class = 'CookieChecker';

use_ok $class;

my $t = Test::Mojo->new($class->new);

subtest 'GET /session/check' => sub {

    $t->get_ok('/session/check')->status_is(200)
        ->header_like('content-type' => qr|^text/javascript|)->content_is("callback('');");
};

subtest 'GET /session/store' => sub {

    $t->get_ok('/session/store?token=hoge')->status_is(200);

    $t->get_ok('/session/store?token=fuga')->status_is(200);

    $t->get_ok('/session/check')->status_is(200)->content_is("callback('fuga');");
};

done_testing;
