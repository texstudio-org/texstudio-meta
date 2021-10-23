#!/usr/bin/perl

use strict;
use warnings;

my $newVersion=$ARGV[0];


print $newVersion;

my $filename = 'index.html';

open(FH, '<', $filename) or die $!;

while(<FH>){
   if( m/releases\/download/ ){
     s/\d\.\d+\.\d+/$newVersion/g;
   }
   if( m/currentVersion/ ){
     s/\d\.\d+\.\d+/$newVersion/g;
   }
   print $_;
}

close(FH);
