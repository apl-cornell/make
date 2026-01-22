#!/usr/bin/env perl

my %inputs;
my %outputs;

if ($#ARGV < 0) {
    print STDERR "Usage: compute_deps.pl <tex-file>\n";
    exit 1;
}

foreach my $filename (@ARGV) {
    my $filename = $ARGV[0];
    $filename =~ s/\.tex$//;

    if (!open(FLS, "$filename.fls")) {
        print STDERR "Cannot open $filename.fls. Build $filename.pdf with the -recorder option.\n";
        exit 1;
    }

    while (<FLS>) {
        my @a = split / /, $_, 2;
        my $cmd = shift @a;
        my $file = shift @a;
        chomp $file;
        if ($cmd eq 'INPUT') {
            $inputs{$file} = 1
        } elsif ($cmd eq 'OUTPUT') {
            $outputs{$file} = 1
        }
    }

    foreach my $k (keys %outputs) {
        $inputs{$k} = 0
    }

    print "$filename.pdf: ";

    my $first = 1;
    foreach my $k (keys %inputs) {
        print " " unless ($first);
        $first = 0;
        if ($inputs{$k}) {
            print $k
        }
    }
    close(FLS);
}
print "\n";
