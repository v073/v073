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
    abstention: Abstention
    default_options:
        yes_no:
            - Yes
            - No
        foo_bar:
            - Foo
            - Bar
            - Baz
EOF
$ENV{V073_CONFIG_FILE}  = $tmp_config_file;
$ENV{V073_DB_FILE}      = $tmp_db_file;

# Prepare lite app test
my $app = curfile->dirname->sibling('backend');
my $t   = Test::Mojo->new($app);
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
        {text => 'Abstention',  type => 'yes_no'},
    ]}, 'Correct yes/no options';

    is_deeply $fb => {name => 'foo_bar', options => [
        {text => 'Foo',         type => 'foo_bar'},
        {text => 'Bar',         type => 'foo_bar'},
        {text => 'Baz',         type => 'foo_bar'},
        {text => 'Abstention',  type => 'foo_bar'},
    ]}, 'Correct foo/bar/baz options';
};

done_testing;
