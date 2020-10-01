use Mojo::Base -strict;

use Test::More;
use Test::Mojo;
use Mojo::File qw(curfile tempfile);

# Prepare test configuration with types
my $tmp_db_file     = tempfile;
my $tmp_config_file = tempfile;
$tmp_config_file->spurt(<<EOF);
db:
    file:           t/TMP_DB_FILE
    schema_file:    schema.sql

token_length: 9

voting:
    abstention: Nothin
    default_options:
        yes_no:
            - Yes
            - No
EOF

# Prepare lite app test
my $app = curfile->dirname->sibling('backend');
my $t   = do {
    local $ENV{V073_CONFIG_FILE} = $tmp_config_file;
    local $ENV{V073_DB_FILE}     = $tmp_db_file;
    Test::Mojo->new($app);
};
$t->app->log->level('warn');

subtest 'Try to retrieve non-existant voting' => sub {
    my $token = $t->app->token;
    $t->get_ok("/voting/$token")
        ->status_is(404)
        ->content_is('Voting not found');
};

subtest 'Create voting' => sub {

    subtest 'with unknown type' => sub {
        $t->post_ok('/voting', form => {
            text => 'xnorfzt',
            type => $t->app->create_free_type_name,
        })->status_is(404)->content_is('Type not found');
    };

    my $token;
    subtest 'with default type' => sub {
        $t->post_ok('/voting', form => {text => 'Foo Bar', type => 'yes_no'})
            ->status_is(200)
            ->json_is('/type'       => 'yes_no')
            ->json_is('/text'       => 'Foo Bar')
            ->json_is('/started'    => 0)
            ->json_is('/closed'     => 0);
        $token = $t->tx->res->json('/token');
        like $token => qr/^[A-Z0-9]{9}$/, 'Token looks good';
    };

    subtest 'Check' => sub {
        $t->get_ok("/voting/$token")
            ->status_is(200)
            ->json_is('/token'      => $token)
            ->json_is('/type'       => 'yes_no')
            ->json_is('/text'       => 'Foo Bar')
            ->json_is('/started'    => 0)
            ->json_is('/closed'     => 0);
    };
};

done_testing;
