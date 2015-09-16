#!/usr/bin/perl

use strict;
use warnings;
use LWP::UserAgent;
use Fcntl;
use Tie::File;

my $cell_number = "6175123459";
my $working_dir = "/home/brewpi";
my $temp_offset = 3; 
my $string;
my $log_file;
my $beer_temp;
my $beer_set;
my $fridge_temp;
my $fridge_set;
my $room_temp;

sub send_txt {

	my $content = $_[0];
	my $ua = LWP::UserAgent->new; 
	my $server_endpoint = "http://textbelt.com/text";
 
	# set custom HTTP request header fields
	my $req = HTTP::Request->new(POST => $server_endpoint);
	$req->header('content-type' => 'application/json');
	$req->header('x-auth-token' => 'kfksj48sdfj4jd9d');
 
	# add POST data to HTTP request body
	my $post_data = '{ "number": "' . $cell_number . '", "message": "' . $content . '" }';
	$req->content($post_data);
 
	my $resp = $ua->request($req);
	if ($resp->is_success) {
    		my $message = $resp->decoded_content;
	}
	else {
    		print "HTTP POST error code: ", $resp->code, "\n";
    		print "HTTP POST error message: ", $resp->message, "\n";
	}
}

sub get_csv {
	my $csv_file = $_[0];
	tie my @rows, 'Tie::File', $csv_file, mode => O_RDONLY or die "error: $!\n";
	my $brew_data = $rows[-1] ;
	my @brew_array = split(/;/, $brew_data);
	
	$beer_temp = "$brew_array[1]";
	$beer_set = "$brew_array[2]";
	$fridge_temp = "$brew_array[4]";
	$fridge_set = "$brew_array[5]";
	$room_temp = "$brew_array[8]";
	
	print " Beer Temp: $beer_temp\n Beer Set: $beer_set\n Fridge Temp:";
	print " $fridge_temp\n Fridge Set: $fridge_set\n Room Temp: $room_temp\n\n";
}

sub get_beer_path {

	my $path_to_config = "/home/brewpi/settings/config.cfg";
	
	open my $handle, '<', $path_to_config;
		chomp(my @lines = <$handle>);
	close $handle;

	my @beer = split(/ /, $lines[0]);
	my $cur_beer = "$beer[2]";
	$log_file = "$working_dir/data/$cur_beer/$cur_beer.csv";
}
#########################
## Start of the script ##
#########################

print "BrewPI Temp Check\n---------------\n";
get_beer_path();
print "Config File: $log_file\n\n";
print "Current Beer Temps:\n\n";
get_csv ($log_file);

my $beer_set_sub = ($beer_set - $temp_offset);
my $beer_set_add = ($beer_set + $temp_offset);

if ($beer_temp < $beer_set_sub || $beer_temp > $beer_set_add) {
	my $string = "WARNING!! Beer Temp: $beer_temp Beer Set: $beer_set Fridge Temp: $fridge_temp";
	print "$string\n";
	send_txt( $string );
} else {
	
	print "Everything Looks Good!\n\n";
} 
