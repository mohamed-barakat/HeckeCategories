# SPDX-License-Identifier: GPL-2.0-or-later
# HeckeCategories: Categorification of Hecke algebras
#
# Declarations
#

#! @Chapter The free Bott-Samelson category

####################################
#
#! @Section GAP categories
#
####################################

#! @Description
#!  The &GAP; category of free Bott-Samelson categories.
DeclareCategory( "IsFreeBottSamelsonCategory",
        IsCapCategory );

#! @Description
#!  The &GAP; category of objects in a free Bott-Samelson category.
DeclareCategory( "IsObjectInFreeBottSamelsonCategory",
        IsCapCategoryObject  );

#! @Description
#!  The &GAP; category of morphisms in a free Bott-Samelson category.
DeclareCategory( "IsMorphismInFreeBottSamelsonCategory",
        IsCapCategoryMorphism );

####################################
#
#! @Section Constructors
#
####################################

#! @Description
#!  
#! @Arguments coxeter_matrix
DeclareOperation( "FreeBottSamelsonCategory",
       [ IsMatrix ] );
#! @InsertChunk FreeBottSamelsonCategory

####################################
#
#! @Section Attributes
#
####################################

#!
DeclareAttribute( "UnderlyingCoxeterMatrix",
        IsFreeBottSamelsonCategory );
