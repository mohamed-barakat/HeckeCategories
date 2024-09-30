# SPDX-License-Identifier: GPL-2.0-or-later
# HeckeCategories: Categorification of Hecke algebras
#
# Implementations
#

InstallMethodWithCache( StandardCategory,
        "for a matrix group and a homalg ring",
        [ IsMatrixGroup, IsHomalgRing ],
        
  function( W, k )
    local d, vars_a, R, Q, phi, name, Std, V;
    
    d := Rank( One( W ) );
    
    vars_a := Concatenation( "a1..", String( d ) );
    
    R := k[vars_a];
    Q := HomalgFieldOfRationalsInSingular( vars_a, k );
    
    phi :=
      function( w )
        local map;
        
        map := RingMap( w * Indeterminates( R ), R, R );
        
        SetIsMorphism( map, true );
        
        return map;
        
    end;
    
    if HasName( W ) then
        name := Name( W );
    else
        name := "W";
    fi;
    
    name := Concatenation( "StandardCategory( ", name, ", ", RingName( k ), " )" );
    
    Std := CreateCapCategory( name,
                   IsStandardCategory,
                   IsObjectInStandardCategory,
                   IsMorphismInStandardCategory,
                   IsCapCategoryTwoCell );
    
    SetUnderlyingMatrixGroup( Std, W );
    SetUnderlyingRing( Std, R );
    SetUnderlyingFieldOfFractions( Std, Q );
    SetUnderlyingTwistingRingMap( Std, phi );
    
    Std!.category_as_first_argument := true;
    
    V := CategoryOfRows( R );
    
    SetIsAbCategory( Std, true );
    SetIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( Std, true );
    SetCommutativeRingOfLinearCategory( Std, Q );
    
    SetRangeCategoryOfHomomorphismStructure( Std, V );
    SetIsEquippedWithHomomorphismStructure( Std, true );
    
    SetIsStrictMonoidalCategory( Std, true );
    
    AddObjectConstructor( Std,
      function( cat, w )
        
        return CreateCapCategoryObjectWithAttributes( cat,
                       MatrixGroupElement, w );
        
    end );
    
    AddObjectDatum( Std,
      function( cat, obj )
        
        return MatrixGroupElement( obj );
        
    end );
    
    AddMorphismConstructor( Std,
      function( cat, source, ring_element, range )
        local datum;
        
        if IsEqualForObjects( cat, source, range ) then
            datum := ring_element;
        else
            datum := Zero( ring_element );
        fi;
        
        return CreateCapCategoryMorphismWithAttributes( cat,
                       source,
                       range,
                       UnderlyingRingElement, datum );
        
    end );
    
    AddMorphismDatum( Std,
      function( cat, obj )
        
        return UnderlyingRingElement( obj );
        
    end );
    
    AddIsWellDefinedForObjects( Std,
      function( cat, obj )
        
        return ObjectDatum( cat, obj ) in UnderlyingMatrixGroup( cat );
        
    end );
    
    AddIsWellDefinedForMorphisms( Std,
      function( cat, mor )
        
        return MorphismDatum( cat, mor ) in UnderlyingFieldOfFractions( cat );
        
    end );
    
    AddIsEqualForObjects( Std,
      function( cat, rx, ry )
        
        return ObjectDatum( cat, rx ) = ObjectDatum( cat, ry );
        
    end );
    
    AddIsEqualForMorphisms( Std,
      function( cat, mor_pre, mor_post )
        
        return MorphismDatum( cat, mor_pre ) = MorphismDatum( cat, mor_post );
        
    end );
    
    AddIsCongruentForMorphisms( Std,
      function( cat, mor_pre, mor_post )
        
        if IsEndomorphism( cat, mor_pre ) then
            return MorphismDatum( cat, mor_pre ) = MorphismDatum( cat, mor_post );
        fi;
        
        return true;
        
    end );
    
    AddPreCompose( Std,
      function( cat, mor_pre, mor_post )
        
        return MorphismConstructor( cat,
                       Source( mor_pre ),
                       MorphismDatum( cat, mor_pre ) * MorphismDatum( cat, mor_post ),
                       Range( mor_post ) );
        
    end );
    
    AddIdentityMorphism( Std,
      function( cat, rx )
        
        return MorphismConstructor( cat,
                       rx,
                       One( UnderlyingFieldOfFractions( cat ) ),
                       rx );
        
    end );
    
    AddAdditionForMorphisms( Std,
      function( cat, mor1, mor2 )
        
        return MorphismConstructor( cat,
                       Source( mor1 ),
                       MorphismDatum( cat, mor1 ) + MorphismDatum( cat, mor2 ),
                       Range( mor1 ) );
        
    end );
    
    AddAdditiveInverseForMorphisms( Std,
      function( cat, mor )
        
        return MorphismConstructor( cat,
                       Source( mor ),
                       -MorphismDatum( cat, mor ),
                       Range( mor ) );
        
    end );
    
    AddZeroMorphism( Std,
      function( cat, rx, ry )
        
        return MorphismConstructor( cat,
                       rx,
                       Zero( UnderlyingFieldOfFractions( cat ) ),
                       ry );
        
    end );
    
    AddMultiplyWithElementOfCommutativeRingForMorphisms( Std,
      function( cat, f, mor )
        
        return MorphismConstructor( cat,
                       Source( mor ),
                       f * MorphismDatum( cat, mor ),
                       Range( mor ) );
        
    end );
    
    AddTensorUnit( Std,
      function( cat )
        
        return ObjectConstructor( cat, One( UnderlyingMatrixGroup( cat ) ) );
        
    end );
    
    AddTensorProductOnObjects( Std,
      function( cat, rx, ry )
        
        return ObjectConstructor( cat,
                       ObjectDatum( cat, rx ) * ObjectDatum( cat, ry ) );
        
    end );
    
    AddTensorProductOnMorphisms( Std,
      function( cat, mor1, mor2 )
        local mor2_datum, phi_x, R, Q;
        
        mor2_datum := MorphismDatum( cat, mor2 );
        
        phi_x := UnderlyingTwistingRingMap( cat )( ObjectDatum( cat, Range( mor1 ) )^-1 );
        
        R := UnderlyingRing( cat );
        Q := UnderlyingFieldOfFractions( cat );
        
        return MorphismConstructor( cat,
                       TensorProductOnObjects( cat, Source( mor1 ), Source( mor2 ) ),
                       MorphismDatum( cat, mor1 ) * ( ( Pullback( phi_x, Numerator( mor2_datum ) / R ) / Q ) / ( Pullback( phi_x, Denominator( mor2_datum ) / R ) / Q ) ),
                       TensorProductOnObjects( cat, Range( mor1 ), Range( mor2 ) ) );
        
    end );
    
    AddBasisOfExternalHom( Std,
      function( cat, rx, ry )
        
        if IsEqualForObjects( cat, rx, ry ) then
            return [ IdentityMorphism( cat, rx ) ];
        fi;
        
        return [ ];
        
    end );
    
    AddCoefficientsOfMorphism( Std,
      function( cat, mor )
        
        if IsEqualForObjects( cat, Source( mor ), Range( mor ) ) then
            return [ MorphismDatum( cat, mor ) ];
        fi;
        
        return [ ];
        
    end );
    
    Std!.compiler_hints :=
      rec( category_attribute_names :=
           [ "UnderlyingMatrixGroup",
             "UnderlyingRing",
             "UnderlyingFieldOfFractions",
             "UnderlyingTwistingRingMap",
             ] );
    
    Finalize( Std );
    
    return Std;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( Display,
        "for an object in a standard category",
        [ IsObjectInStandardCategory ],
        
  function( obj )
    
    Display( ObjectDatum( obj ) );
    
end );

##
InstallMethod( Display,
        "for a morphism in a standard category",
        [ IsMorphismInStandardCategory ],
        
  function( obj )
    
    Print( MorphismDatum( obj ), "\n" );
    
end );
