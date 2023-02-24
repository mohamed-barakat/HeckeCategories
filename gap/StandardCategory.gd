# SPDX-License-Identifier: GPL-2.0-or-later
# HeckeCategories: Categorification of Hecke algebras
#
# Declarations
#

#! @Chapter The standard category

####################################
#
#! @Section GAP categories
#
####################################

#! @Description
#!  The &GAP; category of standard categories.
DeclareCategory( "IsStandardCategory",
        IsCapCategory );

#! @Description
#!  The &GAP; category of cells in a standard category.
DeclareCategory( "IsCellInStandardCategory",
        IsCapCategoryCell );

#! @Description
#!  The &GAP; category of objects in a standard category.
DeclareCategory( "IsObjectInStandardCategory",
        IsCellInStandardCategory and IsCapCategoryObject  );

#! @Description
#!  The &GAP; category of morphisms in a standard category.
DeclareCategory( "IsMorphismInStandardCategory",
        IsCellInStandardCategory and IsCapCategoryMorphism );

####################################
#
#! @Section Constructors
#
####################################

#! @Description
#!  Return the standard category over the commutative base ring <A>k</A>.
#! @Arguments W, k
DeclareOperation( "StandardCategory",
       [ IsGroup, IsHomalgRing ] );
#! @InsertChunk StandardCategory

####################################
#
#! @Section Attributes
#
####################################

#!
DeclareAttribute( "UnderlyingMatrixGroup",
        IsStandardCategory );

#!
DeclareAttribute( "UnderlyingRing",
        IsStandardCategory );

CapJitAddTypeSignature( "UnderlyingRing", [ IsStandardCategory ], IsHomalgRing );

#!
DeclareAttribute( "UnderlyingTwistingRingMap",
        IsStandardCategory );

CapJitAddTypeSignature( "UnderlyingTwistingRingMap", [ IsStandardCategory ], IsHomalgRingMap );

#!
DeclareAttribute( "MatrixGroupElement",
        IsObjectInStandardCategory );

CapJitAddTypeSignature( "MatrixGroupElement", [ IsObjectInStandardCategory ], IsMatrixGroup );

#!
DeclareAttribute( "UnderlyingRingElement",
        IsMorphismInStandardCategory );

CapJitAddTypeSignature( "UnderlyingRingElement", [ IsMorphismInStandardCategory ], IsHomalgRingElement );
