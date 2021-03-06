#!/usr/bin/perl
# 2016/12/26 16:19:06 david
#

$decls = $incls = '';
$namespace = $ARGV[0];

open NODES, "find ast -name \\*.h -print | sed -e 's=ast/==g' | sort | "
  or die "Could not list node headers";
while (<NODES>) {
  if (m/\ball\.h\b/) { next; }
  chomp;
  $decl = $incl = $_;
  #
  # Handle declaration
  #
  $i = $decl =~ s-(([[:alnum:]]|_)+)/--g;
  $decl =~ s-(([[:alnum:]]|_)+?)\.h-class $1; -;
  $decls .= $decl;
  $decls .= "\n";
  #
  # Handle include
  #
  if ($namespace eq "cdk") {
    $incl =~ s-(([[:alnum:]]|_)+?)\.h-#include <cdk/ast/$1.h>-;
  } else {
    #$incl =~ s-(([[:alnum:]]|_)+?)\.h-#include "ast/$1.h"-;
    $incl =~ s=^=#include "ast/=;
    $incl =~ s/$/"/;
  }
  $incls .= "$incl\n";
}
close NODES;

# HACKS!!!

$decls =~ s/class literal_node;/template <typename StoredType> class literal_node;/g;
$cdkallinclude = '';
if ($namespace ne "cdk") {
  $cdkallinclude = "#include <cdk/ast/all.h>\n";
}

###########################################################################
#
# File "nodes/all.h" will now be produced.
#
print<<__EOF__;
//
// **** AUTOMATICALLY GENERATED BY mk-node-decls.pl -- DO NOT EDIT ****
//
$cdkallinclude
#ifdef __NODE_DECLARATIONS_ONLY__

namespace $namespace {
$decls
} // namespace $namespace

#else /* !defined(__NODE_DECLARATIONS_ONLY__) */

#ifndef __AUTOMATIC_${namespace}_NODE_ALLNODES_H__
#define __AUTOMATIC_${namespace}_NODE_ALLNODES_H__

$incls

#endif /* !defined(__AUTOMATIC_${namespace}_NODE_ALLNODES_H__) */

#endif /* !defined(__NODE_DECLARATIONS_ONLY__) */
__EOF__

###########################################################################

0;

###########################################################################
