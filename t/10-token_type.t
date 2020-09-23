use Mojo::Base -strict;

use Test::More;
use Test::Mojo;
use Mojo::File qw(curfile tempfile);

# Inject a test database
$ENV{V073DB} = tempfile;

# Prepare lite app test
my $app = curfile->dirname->sibling('backend');
my $t = Test::Mojo->new($app);
$t->app->log->level('warn');

subtest 'No token' => sub {
    $t->post_ok('/token-type')
        ->status_is(403)
        ->content_is('No token given');
};

subtest 'Unknown token' => sub {
    $t->post_ok('/token-type', form => {token => $t->app->token})
        ->status_is(404)
        ->content_is('Token not found');
};

subtest 'Known tokens' => sub {
    $t->app->data('Type')->delete;
    $t->app->data('Voting')->delete;
    $t->app->data('Token')->delete;

    # Test data
    my $type            = 'type1';
    my $voting_token    = $t->app->token;
    my $voter_token     = $t->app->token;
    isnt $voting_token => $voter_token, 'Different tokens';

    subtest 'Prepare test data' => sub {
        $t->app->data('Type')->create({name => $type});
        my $voting = $t->app->data('Voting')->create({
            type => $type, token => $voting_token,
        });
        my $token = $voting->create_related(tokens => {name => $voter_token});
        is $voting->token => $voting_token, 'Correct voting token';
        is $token->name => $voter_token, 'Correct voter token';
    };

    subtest 'Voting token' => sub {
        $t->post_ok('/token-type', form => {token => $voting_token})
            ->status_is(200)
            ->json_is('/type' => 'voting');
    };

    subtest 'Voter token' => sub {
        $t->post_ok('/token-type', form => {token => $voter_token})
            ->status_is(200)
            ->json_is('/type' => 'vote');
    };
};

done_testing();
