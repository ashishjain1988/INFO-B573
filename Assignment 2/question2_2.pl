#!/usr/bin/perl
$inputFile = 'sequence.fasta';
my $count = 0;
my $sequence = '';
open(SEQUENCE_DATA,"<$inputFile") or die "Could not open $inputFile !";
while(<SEQUENCE_DATA>)  {
        if($count != 0)
                {
                                chomp;
                                 $sequence .= $_;
                }
                     $count += 1;
              }
close(SEQUENCE_DATA);
$resultFile="result_ORF.txt";
$sequence =~ s/[\r\n]//g;
my($len) = length($sequence);
my $count = 0;
my $startCodonIndex = 0;
my $stopCodonIndex = 0;
#$sequence = "ATGTTTTATGAAATAGAATAG";
sub getORF{
my $sequence = $_[0];
#print $sequence,"\n";
my $OUT = $_[1];
my $index = $_[2];
my $len = $_[3]-1;
my $start = 0;
my $startIndex = 0;
my $stopIndex = 0;
my $count = 0;
for(my($i)=$index;$i<($len-2);$i+=3)
{
        my $sub = substr($sequence,$i,3);
        if($start == 0)
        {
        if($sub eq 'ATG')
        {
           $start = 1;
           $startIndex = $i;
        }
        }else
        {
            if($sub eq 'TAA' || $sub eq 'TAG' || $sub eq 'TGA')
        {
                $start = 0;
		$stopIndex = $i;
		$count+=1;
		#print "$count \n";
                print_ORF($startIndex,$stopIndex,$sequence,$OUT,$count);
        }
        }
}
}

sub print_ORF{
my $sequence = $_[2];
my $OUT = $_[3];
my $startIndex = $_[0];
my $stopIndex = $_[1];
my $count1 = $_[4];
my $length = $stopIndex - $startIndex + 3;
 # print "$startIndex $stopIndex $count $length\n";
  my $seq = substr($sequence,$startIndex,$length);
  my $count = 0;
  print $OUT ">ORF $count1 | Mycoplasma genitalium G37 chromosome, ORF\n";
  my $s = "";
  while(($count+60) < $length)
{
  $s = substr($seq,$count,60);
  $count +=60;
  print $OUT "$s\n";
}
  my $s1 = substr($seq,$count,($length-$count));
  print $OUT "$s1\n";
}
open(ORF1,">ORF_RF_1.fasta") or die "Could not output file !";
getORF($sequence,ORF1,0,$len);
close(ORF1);
open(ORF2,">ORF_RF_2.fasta") or die "Could not output file !";
getORF($sequence,ORF2,1,$len);
close(ORF2);
open(ORF3,">ORF_RF_3.fasta") or die "Could not output file !";
getORF($sequence,ORF3,2,$len);
close(ORF3);
print "You can find the ORFs for three different reading frames in files ORF_RF_1.txt,ORF_RF_2.txt,ORF_RF_3.txt in the current folder\n";
