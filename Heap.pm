#!/usr/bin/perl


package Heap;
$VERSION = '0.10';
sub Version {$Version}

sub new {
  my @heap;
  my ($package, $cmp) = @_;
  $heap[0] = $cmp;
  bless \@heap => $package;
}

sub size {
  $#{$_[0]};
}

sub insert {
  my ($self, $n) = @_;
  local *h = $self;
  my $i = @h;
  $h[$i] = $n;
  my $j = int($i/2);
  while ($j > 0) {
    if ($h[0] ? ($h[0]->($h[$i], $h[$j]) < 0) : ($h[$i] > $h[$j])) {
      @h[$i,$j] = @h[$j,$i];
    } else {
      last;
    }
    ($i, $j) = ($j, int($j/2));
  }
}

sub largest {
  my ($self) = @_;
  $self->[1];
}

sub get_largest {
  my ($self) = @_;
  local *h = $self;
  my $largest = $h[1];
  my $i = 1;
  while (defined $h[$i]) {
    my $d;
    my ($a, $b) = @h[2*$i, 2*$i+1];
    if (defined $a && defined $b) {
      $d = 1 - ($h[0] ? ($h[0]->($a, $b) < 0) : ($a > $b))
    } elsif (defined $a) {
      $d = 0;
    } elsif (defined $b) {
      $d = 1;
    } else {
      $d = 0;
    }
    $h[$i] = $h[2*$i+$d];
    $i = $i * 2 + $d;
  }
  $largest;
}

1;

