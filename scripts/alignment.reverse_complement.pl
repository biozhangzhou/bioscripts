#!/usr/bin/perl

#usage: reverse_complement.pl [file.fasta]

#reverse complements DNA 

open(IN,$ARGV[0]);

while(<IN>)
{
    print $_;
    my $dna = <IN>;
    chomp $dna;
    print rc($dna)."\n";
}

close(IN);

sub rc {
    my $str = $_[0];
    # reverse complement
    $str =~ tr/ACGTacgt/TGCAtgca/;
    return scalar reverse $str;
}
