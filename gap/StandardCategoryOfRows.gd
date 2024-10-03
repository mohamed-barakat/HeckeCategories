# SPDX-License-Identifier: GPL-2.0-or-later
# HeckeCategories: Categorification of Hecke algebras
#
# Declarations
#

#! @Chapter The standard category of rows

####################################
#
#! @Section GAP categories
#
####################################

#! @Description
#!  The &GAP; category of standard categories.
DeclareCategory( "IsStandardCategoryOfRows",
        IsCapCategory );

#! @Description
#!  The &GAP; category of cells in a standard category of rows.
DeclareCategory( "IsCellInStandardCategoryOfRows",
        IsCapCategoryCell );

#! @Description
#!  The &GAP; category of objects in a standard category of rows.
DeclareCategory( "IsObjectInStandardCategoryOfRows",
        IsCellInStandardCategoryOfRows and IsCapCategoryObject  );

#! @Description
#!  The &GAP; category of morphisms in a standard category of rows.
DeclareCategory( "IsMorphismInStandardCategoryOfRows",
        IsCellInStandardCategoryOfRows and IsCapCategoryMorphism );

####################################
#
#! @Section Constructors
#
####################################

#! @Description
#!  Return the standard category of rows over the commutative base ring <A>k</A>.
#! @Arguments W, k
DeclareOperation( "StandardCategoryOfRows",
       [ IsGroup, IsHomalgRing ] );
#! @InsertChunk StandardCategoryOfRows

####################################
#
#! @Section Attributes
#
####################################

#!
DeclareAttribute( "PairOfIntAndList",
        IsObjectInStandardCategoryOfRows );

CapJitAddTypeSignature( "PairOfIntAndList", [ IsObjectInStandardCategoryOfRows ],
 function ( input_types )
    
    Assert( 0, IsStandardCategoryOfRows( input_types[1].category ) );
    
    return CapJitDataTypeOfNTupleOf( 2,
                   IsBigInt,
                   CapJitDataTypeOfListOf( CapJitDataTypeOfObjectOfCategory( Source( UnderlyingPreSheaf( input_types[1].category ) ) ) ) );
    
end );

#!
DeclareAttribute( "UnderlyingMatrix",
        IsMorphismInStandardCategoryOfRows );

CapJitAddTypeSignature( "UnderlyingMatrix", [ IsMorphismInStandardCategoryOfRows ],
 function ( input_types )
    
    Assert( 0, IsStandardCategoryOfRows( input_types[1].category ) );
    
    return rec( filter := IsHomalgMatrix, ring := CommutativeRingOfLinearCategory( input_types[1].category ) );
    
end );

#!
DeclareAttribute( "UnderlyingMatrixGroup",
        IsStandardCategoryOfRows );

#!
DeclareAttribute( "UnderlyingRing",
        IsStandardCategoryOfRows );

#!
DeclareAttribute( "UnderlyingFieldOfFractions",
        IsStandardCategoryOfRows );

CapJitAddTypeSignature( "UnderlyingRing", [ IsStandardCategoryOfRows ], IsHomalgRing );

#!
DeclareAttribute( "UnderlyingTwistingRingMap",
        IsStandardCategoryOfRows );

CapJitAddTypeSignature( "UnderlyingTwistingRingMap", [ IsStandardCategoryOfRows ], IsHomalgRingMap );

#!
DeclareAttribute( "MatrixGroupElement",
        IsObjectInStandardCategoryOfRows );

CapJitAddTypeSignature( "MatrixGroupElement", [ IsObjectInStandardCategoryOfRows ], IsMatrixGroup );

#!
DeclareAttribute( "UnderlyingRingElement",
        IsMorphismInStandardCategoryOfRows );

CapJitAddTypeSignature( "UnderlyingRingElement", [ IsMorphismInStandardCategoryOfRows ], IsHomalgRingElement );
