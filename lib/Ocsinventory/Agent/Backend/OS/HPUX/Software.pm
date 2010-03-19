package Ocsinventory::Agent::Backend::OS::HPUX::Software;

sub check  { 
   my $params = shift;

   # Do not run an package inventory if there is the --nosoft parameter
   return if ($params->{params}->{nosoft});

   $^O =~ /hpux/ 
}

sub run {
   my $params = shift;
   my $inventory = $params->{inventory};

   my @softList;
   my $software;

   

   @softList = `swlist | grep -v '^  PH' | grep -v '^#' |tr -s "\t" " "|tr -s " "` ;
   foreach $software (@softList) {
      chomp( $software );
      if ( $software =~ /^ (\S+)\s(\S+)\s(.+)/ ) {
         $inventory->addSoftwares({
                        'NAME'          => $1  ,
                        'VERSION'       => $2 ,
                        'COMMENTS'      => $3 ,
                        'PUBLISHER'     => "HP" ,
				  });
       }
    }

 }

1;