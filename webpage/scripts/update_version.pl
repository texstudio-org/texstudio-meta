#!/usr/bin/perl

use strict;
use warnings;

my $newVersion=$ARGV[0];

# read linux table if exits
my $TH;
if( -e "/tmp/table.html" ){
  open($TH, '<', '/tmp/table.html');
}

my $filename = 'index.html';

open(FH, '<', $filename) or die $!;
my $doPrint=1;

while(<FH>){
  if( m/releases\/download/ ){
    s/\d\.\d+\.\d+/$newVersion/g;
  }
  if( m/currentVersion/ ){
    s/\d\.\d+\.\d+/$newVersion/g;
  }
  if( !$doPrint && m/\/tbody/){
    $doPrint=1;
  }
  if( m/tbody.*linuxdownloads/){
    print $_;
    if(defined $TH){
      $doPrint=0;
      while(<$TH>){
        if( m/<.?table>/){ 
          next;
        }
        print $_;
      }
    }
  }
  print $_ if $doPrint;
}

close(FH);
