package CookieChecker;
use strict;
use warnings;
use parent 'Mojolicious';

sub startup {
    my $self = shift;

    SESSIONS: {
        $self->sessions->cookie_name('cookie-checker');
    }

    ROUTES: {
        $self->routes->get('/session/store')->to(
            cb => sub {
                my $c = shift;
                $c->session->{token} = $c->req->params->to_hash->{token} || '';
                $c->render(data => 'OK', format => 'text');
            }
        );

        $self->routes->get('/session/check')->to(
            cb => sub {
                my $c = shift;
                my $token = $c->session->{token} || '';
                $c->res->headers->header('content-type' => 'text/javascript;charset=utf-8');
                $c->render(data => "callback('$token');");
            }
        );
    }
}

1;
