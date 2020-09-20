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
    $t->post_ok('/token')
        ->status_is(404)
        ->json_is('/message' => 'Token not found');
};

subtest 'Unknown token' => sub {
    $t->post_ok('/token', form => {token => 'Kniewurst42'})
        ->status_is(404)
        ->json_is('/message' => 'Token not found');
};

subtest 'Voting token' => sub {
    $t->app->data('Type')->delete;
    $t->app->data('Voting')->delete;

    # Test data
    my $type_name       = 'type0';
    my $voting_text     = 'voting0';
    my $voting_token    = $t->app->token;
    my $expected        = {
        type    => $type_name,
        token   => $voting_token,
        text    => $voting_text,
        started => 0,
        closed  => 0,
    };

    subtest 'Prepare test data' => sub {
        $t->app->data('Type')->create({name => $type_name});
        my $voting_id = $t->app->data('Voting')->create({
            type    => $type_name,
            token   => $voting_token,
            text    => $voting_text,
        })->id;
        $expected->{id} = $voting_id;
        my $voting = $t->app->data('Voting')->search({token => $voting_token})->first;
        is_deeply {$voting->get_columns} => $expected, 'Correct test data';
    };

    subtest Dispatch => sub {
        $t->post_ok('/token', form => {token => $voting_token})
            ->status_is(200)
            ->json_is('/type' => 'voting')
            ->json_is('/voting' => $expected);
    };
};

subtest 'Voter token' => sub {
    $t->app->data('Type')->delete;
    $t->app->data('Voting')->delete;
    $t->app->data('Token')->delete;

    # Test data
    my $type_name       = 'type1';
    my $voting_text     = 'voting1';
    my $voting_token    = $t->app->token;
    my $voter_token     = $t->app->token;
    my $expected_voting = {
        type    => $type_name,
        token   => $voting_token,
        text    => $voting_text,
        started => 0,
        closed  => 0,
    };
    isnt $voting_token => $voter_token, 'Different tokens';

    subtest 'Prepare test data' => sub {
        $t->app->data('Type')->create({name => $type_name});
        my $voting_id = $t->app->data('Voting')->create({
            type    => $type_name,
            token   => $voting_token,
            text    => $voting_text,
        })->id;
        $expected_voting->{id} = $voting_id;
        my $voting = $t->app->data('Voting')->first;
        $voting->create_related(tokens => {name => $voter_token});
        my $token = $t->app->data('Token')->search({name => $voter_token})->first;
        is $token->name => $voter_token, 'Correct voter token';
    };

    subtest Dispatch => sub {
        $t->post_ok('/token', form => {token => $voter_token})
            ->status_is(200)
            ->json_is('/type' => 'vote')
            ->json_is('/token' => $voter_token)
            ->json_is('/voting' => $expected_voting);
    };
};

done_testing();
