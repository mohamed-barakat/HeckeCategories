# SPDX-License-Identifier: GPL-2.0-or-later
# HeckeCategories: Categorification of Hecke algebras
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "HeckeCategories",
Subtitle := "Categorification of Hecke algebras",
Version := "2024.09-01",

Date := (function ( ) if IsBound( GAPInfo.SystemEnvironment.GAP_PKG_RELEASE_DATE ) then return GAPInfo.SystemEnvironment.GAP_PKG_RELEASE_DATE; else return Concatenation( ~.Version{[ 1 .. 4 ]}, "-", ~.Version{[ 6, 7 ]}, "-01" ); fi; end)( ),
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Mohamed",
    LastName := "Barakat",
    WWWHome := "https://mohamed-barakat.github.io/",
    Email := "mohamed.barakat@uni-siegen.de",
    PostalAddress := Concatenation(
               "Walter-Flex-Str. 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Daniel",
    LastName := "Juteau",
    WWWHome := "https://www.lamfa.u-picardie.fr/annuaire/danjuteau",
    Email := "daniel.juteau@u-picardie.fr",
    PostalAddress := Concatenation(
               "LAMFA\n",
               "CNRS\n",
               "Université de Picardie Jules Verne\n",
               "33, rue Saint-Leu\n",
               "80039 Amiens\n",
               "France" ),
    Place := "Amiens",
    Institution := "Université de Picardie Jules Verne",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Damián",
    LastName := "de la Fuente",
    WWWHome := "https://github.com/damian-delafuente/",
    Email := "damiandlfa@gmail.com",
    PostalAddress := Concatenation(
               "LAMFA\n",
               "Université de Picardie Jules Verne\n",
               "33, rue Saint-Leu\n",
               "80039 Amiens\n",
               "France" ),
    Place := "Amiens",
    Institution := "Université de Picardie Jules Verne",
  ),
],

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/HeckeCategories",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/HeckeCategories",
PackageInfoURL  := "https://homalg-project.github.io/HeckeCategories/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/HeckeCategories/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/HeckeCategories/releases/download/v", ~.Version, "/HeckeCategories-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "HeckeCategories",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Categorification of Hecke algebras",
),

Dependencies := rec(
  GAP := ">= 4.12.1",
  NeededOtherPackages := [
                [ "RingsForHomalg", ">= 2023.02-02" ],
                [ "CAP", ">= 2024.09-05" ],
                [ "MonoidalCategories", ">= 2023.02-04" ],
                [ "FreydCategoriesForCAP", ">= 2023.02-01" ],
                [ "FunctorCategories", ">= 2024.09-11" ],
                ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

));
