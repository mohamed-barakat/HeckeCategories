# SPDX-License-Identifier: GPL-2.0-or-later
# HeckeCategories: Categorification of Hecke algebras
#
# Declarations
#

#! @Chapter The groupoid category

####################################
#
#! @Section GAP categories
#
####################################

#! @Description
#!  The &GAP; category of groupoid categories.
DeclareCategory( "IsGroupoidCategory",
        IsCapCategory );

#! @Description
#!  The &GAP; category of cells in a groupoid category.
DeclareCategory( "IsCellInGroupoidCategory",
        IsCapCategoryCell );

#! @Description
#!  The &GAP; category of objects in a groupoid category.
DeclareCategory( "IsObjectInGroupoidCategory",
        IsCellInGroupoidCategory and IsCapCategoryObject  );

#! @Description
#!  The &GAP; category of morphisms in a groupoid category.
DeclareCategory( "IsMorphismInGroupoidCategory",
        IsCellInGroupoidCategory and IsCapCategoryMorphism );

####################################
#
#! @Section Constructors
#
####################################

#! @Description
#!  Return the groupoid category over the commutative base ring <A>k</A>.
#! @Arguments W, k
DeclareOperation( "GroupoidCategory",
       [ IsGroup, IsHomalgRing ] );
#! @InsertChunk GroupoidCategory

####################################
#
#! @Section Attributes
#
####################################

#!
DeclareAttribute( "UnderlyingPreSheaf",
        IsGroupoidCategory );

#!
DeclareAttribute( "UnderlyingMatrixGroup",
        IsGroupoidCategory );

#!
DeclareAttribute( "UnderlyingRing",
        IsGroupoidCategory );

#!
DeclareAttribute( "UnderlyingFieldOfFractions",
        IsGroupoidCategory );

CapJitAddTypeSignature( "UnderlyingRing", [ IsGroupoidCategory ], IsHomalgRing );

#!
DeclareAttribute( "UnderlyingTwistingRingMap",
        IsGroupoidCategory );

CapJitAddTypeSignature( "UnderlyingTwistingRingMap", [ IsGroupoidCategory ], IsHomalgRingMap );

#!
DeclareAttribute( "MatrixGroupElement",
        IsObjectInGroupoidCategory );

CapJitAddTypeSignature( "MatrixGroupElement", [ IsObjectInGroupoidCategory ], IsMatrixGroup );

#!
DeclareAttribute( "UnderlyingRingElement",
        IsMorphismInGroupoidCategory );

CapJitAddTypeSignature( "UnderlyingRingElement", [ IsMorphismInGroupoidCategory ], IsHomalgRingElement );
