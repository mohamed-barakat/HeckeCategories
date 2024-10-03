# SPDX-License-Identifier: GPL-2.0-or-later
# HeckeCategories: Categorification of Hecke algebras
#
# Declarations
#

#! @Chapter The standard category of columns

####################################
#
#! @Section GAP categories
#
####################################

#! @Description
#!  The &GAP; category of standard categories.
DeclareCategory( "IsStandardCategoryOfColumns",
        IsCapCategory );

#! @Description
#!  The &GAP; category of cells in a standard category of columns.
DeclareCategory( "IsCellInStandardCategoryOfColumns",
        IsCapCategoryCell );

#! @Description
#!  The &GAP; category of objects in a standard category of columns.
DeclareCategory( "IsObjectInStandardCategoryOfColumns",
        IsCellInStandardCategoryOfColumns and IsCapCategoryObject  );

#! @Description
#!  The &GAP; category of morphisms in a standard category of columns.
DeclareCategory( "IsMorphismInStandardCategoryOfColumns",
        IsCellInStandardCategoryOfColumns and IsCapCategoryMorphism );

####################################
#
#! @Section Constructors
#
####################################

#! @Description
#!  Return the standard category of columns over the commutative base ring <A>k</A>.
#! @Arguments W, k
DeclareOperation( "StandardCategoryOfColumns",
       [ IsGroup, IsHomalgRing ] );
#! @InsertChunk StandardCategoryOfColumns

####################################
#
#! @Section Attributes
#
####################################

#!
DeclareAttribute( "PairOfIntAndList",
        IsObjectInStandardCategoryOfColumns );

CapJitAddTypeSignature( "PairOfIntAndList", [ IsObjectInStandardCategoryOfColumns ],
 function ( input_types )
    
    Assert( 0, IsStandardCategoryOfColumns( input_types[1].category ) );
    
    return CapJitDataTypeOfNTupleOf( 2,
                   IsBigInt,
                   CapJitDataTypeOfListOf( CapJitDataTypeOfObjectOfCategory( Source( UnderlyingPreSheaf( input_types[1].category ) ) ) ) );
    
end );

#!
DeclareAttribute( "UnderlyingMatrix",
        IsMorphismInStandardCategoryOfColumns );

CapJitAddTypeSignature( "UnderlyingMatrix", [ IsMorphismInStandardCategoryOfColumns ],
 function ( input_types )
    
    Assert( 0, IsStandardCategoryOfColumns( input_types[1].category ) );
    
    return rec( filter := IsHomalgMatrix, ring := CommutativeRingOfLinearCategory( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingMatrixGroup",
        IsStandardCategoryOfColumns );

#!
DeclareAttribute( "UnderlyingRing",
        IsStandardCategoryOfColumns );

#!
DeclareAttribute( "UnderlyingFieldOfFractions",
        IsStandardCategoryOfColumns );

CapJitAddTypeSignature( "UnderlyingRing", [ IsStandardCategoryOfColumns ], IsHomalgRing );

#!
DeclareAttribute( "UnderlyingTwistingRingMap",
        IsStandardCategoryOfColumns );

CapJitAddTypeSignature( "UnderlyingTwistingRingMap", [ IsStandardCategoryOfColumns ], IsHomalgRingMap );

#!
DeclareAttribute( "MatrixGroupElement",
        IsObjectInStandardCategoryOfColumns );

CapJitAddTypeSignature( "MatrixGroupElement", [ IsObjectInStandardCategoryOfColumns ], IsMatrixGroup );

#!
DeclareAttribute( "UnderlyingRingElement",
        IsMorphismInStandardCategoryOfColumns );

CapJitAddTypeSignature( "UnderlyingRingElement", [ IsMorphismInStandardCategoryOfColumns ], IsHomalgRingElement );
