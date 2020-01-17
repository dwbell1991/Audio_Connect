#!/usr/bin/perl
use strict;
use warnings;

#Sound card must NOT be active whilst, changing cards. 
#Will still work, but need to restart that application. (Linux Problem).
my $choice = mainMenu();
if($choice ==1){
	monitor();
}elsif($choice ==2){
	headphones();
}else{
	
}

sub mainMenu {
	print "\n========================================================\n";
	print "Audio Manager v1.0\n";
	print "[1] Use monitor speakers\n";
	print "[2] Use headphone speakers\n";
	print "Your choice: ";
	my $choice = <STDIN>;
	print "\n";

	return $choice;
}

#Use LG Widescreen monitor
sub monitor {
	#The physical hardware location hw(1,7)
	my $card = 1;
	my $dev = 7;
	parseSoundConfig($card, $dev);
	my $tmp = `alsactl restore -f /var/lib/alsa/monitor.state`;
	print "$tmp";
}

#Use standard headphone jack
sub headphones {
	my $card = 0;
	my $dev = 0;
	parseSoundConfig($card, $dev);
	`alsactl restore -f /var/lib/alsa/headphone.state`;
}

sub parseSoundConfig() {
	my($card, $dev) = @_;
	my $file = `cat /home/logiquol/.asoundrc`;
	my @lines = split(/\n/,$file);
	$lines[0] = $lines[0]."\n";
	$lines[1]  = $lines[1]."\n";
	substr($lines[2], -1) = "$card\n";
	substr($lines[3], -1) = "$dev\n";
	$lines[4] = $lines[4]."\n";
	
	$lines[5] = $lines[5]."\n";
	$lines[6]  = $lines[6]."\n";
	substr($lines[7], -1) = "$card\n";
	substr($lines[8], -1) = "$dev\n";
	$lines[9] = $lines[9]."\n";
	
	my $join = join("", @lines);
	`echo "$join" >/home/logiquol/.asoundrc`;
}
