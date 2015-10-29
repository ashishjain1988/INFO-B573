#!/usr/bin/perl
sub getCodonFrequency
{
my($sequence) = $_[0];
my($fh) = $_[1];
#print "\n $sequence";
@bases = ('A','G','C','T');
my %codon_types = ();
	for($i=0;$i<@bases;$i++)
	{
	for($j=0;$j<@bases;$j++)
	{	for($k=0;$k<@bases;$k++)
		{
			$current_codon = $bases[$i] . $bases[$j] . $bases[$k];
			$codon_types{$current_codon} = 0;
		}
	}
	}
for($count = 0;$count<(length($sequence)-2);$count += 3)
{
	my $codon = substr($sequence,$count,3);
	if(exists $codon_types{$codon})
	{
	$codon_types{$codon}++;
	}else
	{
	print "\n Nucletoide not in map is $codon";
	}
}

$no = 0;
$message = "Codon Frequency \n";
print $fh $message;
foreach $i (keys %codon_types)
{
	if($codon_types{$i} > 0)
{
	print $fh "$i $codon_types{$i} \n";
	$no += (3 * $codon_types{$i});
}else
{
	print $fh "$i -\n";
}
}
#print "\n Number of nucleotides is $no\n";	
}


sub getDiNucleotideFrequency{
#my($sequence) = @_;
my($sequence) = $_[0];
my($fh) = $_[1];
@bases = ('A','G','C','T');
my %codon_types = ();
        for($i=0;$i<@bases;$i++)
        {
        for($j=0;$j<@bases;$j++)
                {
                        $current_codon = $bases[$i] . $bases[$j];
                        $codon_types{$current_codon} = 0;
        }
        }
for($count = 0;$count<(length($sequence)-1);$count += 2)
{
        my $codon = substr($sequence,$count,2);
        $codon_types{$codon} = ($codon_types{$codon} + 1);
}

print $fh "Dinucleotide Frequency\n";
foreach $i (keys %codon_types)
{
        if($codon_types{$i} > 0)
{
        print $fh  "$i $codon_types{$i} \n";
}else
{
	print $fh "$i -\n";
}
}

}
sub getProteinTranslation{
#my($sequence) = @_;
my($sequence) = $_[0];
my($fh) = $_[1];

my(%genetic_code) = (
'TCA' => 'S', # Serine
'TCC' => 'S', # Serine
'TCG' => 'S', # Serine
'TCT' => 'S', # Serine
'TTC' => 'F', # Phenylalanine
'TTT' => 'F', # Phenylalanine
'TTA' => 'L', # Leucine
'TTG' => 'L', # Leucine
'TAC' => 'Y', # Tyrosine
'TAT' => 'Y', # Tyrosine
'TAA' => '_', # Stop
'TAG' => '_', # Stop
'TGC' => 'C', # Cysteine
'TGT' => 'C', # Cysteine
'TGA' => '_', # Stop
'TGG' => 'W', # Tryptophan
'CTA' => 'L', # Leucine
'CTC' => 'L', # Leucine
'CTG' => 'L', # Leucine
'CTT' => 'L', # Leucine
'CCA' => 'P', # Proline
'CCC' => 'P', # Proline
'CCG' => 'P', # Proline
'CCT' => 'P', # Proline
'CAC' => 'H', # Histidine
'CAT' => 'H', # Histidine
'CAA' => 'Q', # Glutamine
'CAG' => 'Q', # Glutamine
'CGA' => 'R', # Arginine
'CGC' => 'R', # Arginine
'CGG' => 'R', # Arginine
'CGT' => 'R', # Arginine
'ATA' => 'I', # Isoleucine
'ATC' => 'I', # Isoleucine
'ATT' => 'I', # Isoleucine
'ATG' => 'M', # Methionine
'ACA' => 'T', # Threonine
'ACC' => 'T', # Threonine
'ACG' => 'T', # Threonine
'ACT' => 'T', # Threonine
'AAC' => 'N', # Asparagine
'AAT' => 'N', # Asparagine
'AAA' => 'K', # Lysine
'AAG' => 'K', # Lysine
'AGC' => 'S', # Serine
'AGT' => 'S', # Serine
'AGA' => 'R', # Arginine
'AGG' => 'R', # Arginine
'GTA' => 'V', # Valine
'GTC' => 'V', # Valine
'GTG' => 'V', # Valine
'GTT' => 'V', # Valine
'GCA' => 'A', # Alanine
'GCC' => 'A', # Alanine
'GCG' => 'A', # Alanine
'GCT' => 'A', # Alanine
'GAC' => 'D', # Aspartic Acid
'GAT' => 'D', # Aspartic Acid
'GAA' => 'E', # Glutamic Acid
'GAG' => 'E', # Glutamic Acid
'GGA' => 'G', # Glycine
'GGC' => 'G', # Glycine
'GGG' => 'G', # Glycine
'GGT' => 'G', # Glycine
);

$protein = '';
for($i=0;$i<(length($sequence)-2);$i = $i + 3)
{
	if(exists $genetic_code{substr($sequence,$i,3)})
	{	
		$protein .= $genetic_code{substr($sequence,$i,3)};	
	}
}

print $fh "\nProtein Sequence is:\n$protein\n";

}


$inputFile = 'Sequence.txt';
my $count = 0;
my $sequence = '';
#getCodonFrequency();
#getDiNucleotideFrequency();
#getProteinTranslation();
open(SEQUENCE_DATA,"<$inputFile") or die "Could not open $inputFile !";
while(<SEQUENCE_DATA>)  { 
	if($count != 0)
	{
#	print "$line $count";
	chomp;
	 $sequence .= $_;
}
$count += 1;
}
close(SEQUENCE_DATA);
$resultFile="result.txt";
open(OUT,">$resultFile") or die "Could not open $resultFile";
$sequence =~ s/[\r\n]//g;
getCodonFrequency($sequence,OUT);
getDiNucleotideFrequency($sequence,OUT);
getProteinTranslation($sequence,OUT);
close(OUT);
print "The results are stored in result.txt file in the current folder.\n";
#print length($sequence);

