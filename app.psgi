use strict;
use warnings;
use lib 'lib';

use CookieChecker;
use Mojo::Server::PSGI;

my $app = Mojo::Server::PSGI->new({ app => CookieChecker->new });

$app->to_psgi_app;
