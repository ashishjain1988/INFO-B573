#!/usr/bin/perl

my $inputFile = "U00096.gbk";
my $tempFile = "TempFile.txt";
my $count = 0;
open(IN,"<$inputFile") or die "Could not open $inputFile !";
$/ = "FEATURES";
$s = "";
open(OUT,">$tempFile") or die "Could not open $tempFile";
while(<IN>)  {
      if($count == 1)
        {
        chomp;
        #print $_;
	print OUT $_;
	}
$/ = "ORIGIN";
$count += 1;
}
close(OUT);
close(IN);

open(IN,"<$tempFile") or die "Could not open $tempFile !";
$count = 0;
$/ = "     CDS";
my @CDS;
while(<IN>)
{
if($count%2 == 0)
{
$/ = "     gene";
}
      if($count%2 == 1)
        {
        chomp;
        #print $_,"\n";
        $s = $_;
	push @CDS,$s;
        $/="     CDS";
        }
$count+=1;
}
close(IN);
$/ = "%%\n";
my $resFile = "result.txt";
open(OUT,">$resFile") or die "Could not open $resFile";

for($i=0;$i<@CDS;$i++)
{
  $count = 1;
  $trans = 'false';
#  print $CDS[$i];
  @cdsLines = split /\n/, $CDS[$i];
  $size = $cdsLines;
 # print scalar(@cdsLines),"\n";
  for($j=0;$j<@cdsLines;$j++)
  {
	my $s1 = $cdsLines[$j];
	$s1 =~ s/^\s+|\s+$//g;
	if($trans eq 'true')
	{
  if(index($s1, '"') != -1)
  {
   $trans = 'false';
   $gene1 = (split('"',$s1))[0];
   print OUT $gene1,"\t";
  }else
  {
   print OUT $s1;
  }
	}elsif($j == 0)
	{
	print OUT $s1,"\t";
	#print $s1;
	}elsif(index($s1, 'gene="') != -1) {
    	$gene = (split('gene="',$s1))[1];
	$gene1 = (split('"',$gene))[0];
 #print $gene1;
	print OUT $gene1,"\t";
	}elsif(index($s1, 'locus_tag') != -1) {
        $gene = (split('locus_tag="',$s1))[1];
        $gene1 = (split('"',$gene))[0];
       print OUT $gene1,"\t";
       }
	elsif(index($s1, 'product') != -1) {
       $gene = (split('product="',$s1))[1];
       #$gene1 = (split('"',$gene))[0];
       if(index($gene, '"') == -1)
       {
        $trans = 'true';
        print OUT $gene;
       }else
       {
        $gene1 = (split('"',$gene))[0];
        print OUT $gene1,"\t";
       }
       
       
       }elsif(index($s1, 'translation') != -1) {
       $gene = (split('translation="',$s1))[1];
if (index($gene, '"') != -1) {
$gene1 = (split('"',$gene))[0];
      print OUT $gene1;
}else	{
       print OUT $gene;
$trans = 'true';
	}
#$trans = 'true';
      }
$count +=1;
  }

print OUT "\n";
	 
}
print "Results can be found in the result.txt file.\n";
close(OUT);


