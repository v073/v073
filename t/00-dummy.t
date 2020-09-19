use Mojo::Base -strict;

use Test::More;
use Test::Mojo;
use Mojo::File 'curfile';

# Prepare lite app test
my $app = curfile->dirname->sibling('v073-backend');
my $t = Test::Mojo->new($app);
$t->app->log->level('warn');

subtest 'Home: answer data' => sub {
    $t->get_ok('/')->status_is(200)->json_is('/answer' => 42);
};

done_testing();
