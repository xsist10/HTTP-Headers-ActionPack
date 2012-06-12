
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "HTTP Action, Adventure and Excitement",
  "AUTHOR" => "Stevan Little <stevan.little\@iinteractive.com>",
  "BUILD_REQUIRES" => {
    "Test::Fatal" => "0.003",
    "Test::More" => "0.88"
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "HTTP-Headers-ActionPack",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "HTTP::Headers::ActionPack",
  "PREREQ_PM" => {
    "HTTP::Date" => 0,
    "HTTP::Message" => 0,
    "MIME::Base64" => 0,
    "Module::Runtime" => 0,
    "URI" => 0
  },
  "VERSION" => "0.01",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



