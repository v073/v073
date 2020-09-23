package V073::Data;
use Mojo::Base -base, -signatures;

use DBI;
use V073::Data::DB;

has db_file     => sub { die "no db_file given!\n" };
has schema_file => sub { die "no schema_file given!\n" };
has dsn         => sub { 'dbi:SQLite:dbname=' . shift->db_file };
has db          => sub { shift->_init };

sub _init ($self) {

    # Create DB from schema, if neccessary
    unless (-e $self->db_file) {
        my $dbh = DBI->connect($self->dsn, '', '', {sqlite_unicode => 1});
        $dbh->do($_) for split /;/ => $self->schema_file->slurp;
    }

    # Connect DBIC schema loader
    local $ENV{SCHEMA_LOADER_BACKCOMPAT} = 1;
    return V073::Data::DB->connect($self->dsn, '', '', {sqlite_unicode => 1});
}

sub helper ($self, $rs) { defined($rs) ? $self->db->resultset($rs) : $self->db }

1;
