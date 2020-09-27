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
    abstention: Enthaltung
    default_options:
        yes_no:
            - Yes
            - No
        foo_bar:
            - Foo
            - Bar
            - Baz
EOF

# Prepare lite app test
my $app = curfile->dirname->sibling('backend');
my $t   = do {
    local $ENV{V073_CONFIG_FILE} = $tmp_config_file;
    local $ENV{V073_DB_FILE}     = $tmp_db_file;
    Test::Mojo->new($app);
};
$t->app->log->level('warn');

subtest 'Correct initial types' => sub {

    # Retrieve both types as hash refs
    my ($yn, $fb) = map {$t->app->data('Type')->find($_, {prefetch => 'options',
        result_class => 'DBIx::Class::ResultClass::HashRefInflator',
    })} qw(yes_no foo_bar);
    delete $_->{id} for @{$yn->{options}}, @{$fb->{options}};

    is_deeply $yn => {name => 'yes_no', options => [
        {text => 'Yes',         type => 'yes_no'},
        {text => 'No',          type => 'yes_no'},
        {text => 'Enthaltung',  type => 'yes_no'},
    ]}, 'Correct yes/no options';

    is_deeply $fb => {name => 'foo_bar', options => [
        {text => 'Foo',         type => 'foo_bar'},
        {text => 'Bar',         type => 'foo_bar'},
        {text => 'Baz',         type => 'foo_bar'},
        {text => 'Enthaltung',  type => 'foo_bar'},
    ]}, 'Correct foo/bar/baz options';
};

subtest 'Default types retrieval' => sub {

    subtest 'Try /types' => sub {
        $t->get_ok('/types')
            ->status_is(302)
            ->header_is(location => '/types/default');
    };

    subtest 'Get JSON data' => sub {
        $t->get_ok('/types/default')
            ->status_is(200)
            ->json_is('/yes_no'  => [qw( Yes No Enthaltung )])
            ->json_is('/foo_bar' => [qw( Foo Bar Baz Enthaltung )]);
    };
};

done_testing;
