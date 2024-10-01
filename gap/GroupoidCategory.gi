# SPDX-License-Identifier: GPL-2.0-or-later
# HeckeCategories: Categorification of Hecke algebras
#
# Implementations
#

InstallOtherMethod( GroupoidCategory,
        "for a presheaf",
        [ IsObjectInPreSheafCategory ],
        
  function( W )
    local PSh, W_datum, d, vars_a, k, R, Q, phi, name, GrpCat, V;
    
    PSh := CapCategory( W );
    
    W_datum := ObjectDatum( W );
    
    d := ObjectDatum( W_datum[1][1] );
    
    vars_a := Concatenation( "a1..", String( d ) );
    
    k := CommutativeRingOfLinearCategory( PSh );
    R := k[vars_a];
    Q := HomalgFieldOfRationalsInSingular( vars_a, k );
    
    #vars_a := HomalgMatrix( Indeterminates( R ), d, 1, R );
    
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
    
    name := Concatenation( "GroupoidCategory( ", RingName( Q ), ", ", name, " )" );
    
    GrpCat := CreateCapCategory( name,
                      IsGroupoidCategory,
                      IsObjectInGroupoidCategory,
                      IsMorphismInGroupoidCategory,
                      IsCapCategoryTwoCell );
    
    SetUnderlyingPreSheaf( GrpCat, W );
    SetUnderlyingMatrixGroup( GrpCat, UnderlyingMatrixGroup( W ) );
    SetUnderlyingRing( GrpCat, R );
    SetUnderlyingFieldOfFractions( GrpCat, Q );
    SetUnderlyingTwistingRingMap( GrpCat, phi );
    
    GrpCat!.category_as_first_argument := true;
    
    V := CategoryOfRows( R );
    
    SetIsAbCategory( GrpCat, true );
    SetIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( GrpCat, true );
    SetCommutativeRingOfLinearCategory( GrpCat, Q );
    
    SetRangeCategoryOfHomomorphismStructure( GrpCat, V );
    SetIsEquippedWithHomomorphismStructure( GrpCat, true );
    
    SetIsStrictMonoidalCategory( GrpCat, true );
    
    AddObjectConstructor( GrpCat,
      function( cat, w )
        
        return CreateCapCategoryObjectWithAttributes( cat,
                       MatrixGroupElement, w );
        
    end );
    
    AddObjectDatum( GrpCat,
      function( cat, obj )
        
        return MatrixGroupElement( obj );
        
    end );
    
    AddMorphismConstructor( GrpCat,
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
    
    AddMorphismDatum( GrpCat,
      function( cat, obj )
        
        return UnderlyingRingElement( obj );
        
    end );
    
    AddIsWellDefinedForObjects( GrpCat,
      function( cat, obj )
        
        return ObjectDatum( cat, obj ) in UnderlyingMatrixGroup( cat );
        
    end );
    
    AddIsWellDefinedForMorphisms( GrpCat,
      function( cat, mor )
        
        return MorphismDatum( cat, mor ) in UnderlyingFieldOfFractions( cat );
        
    end );
    
    AddIsEqualForObjects( GrpCat,
      function( cat, rx, ry )
        
        return ObjectDatum( cat, rx ) = ObjectDatum( cat, ry );
        
    end );
    
    AddIsEqualForMorphisms( GrpCat,
      function( cat, mor_pre, mor_post )
        
        return MorphismDatum( cat, mor_pre ) = MorphismDatum( cat, mor_post );
        
    end );
    
    AddIsCongruentForMorphisms( GrpCat,
      function( cat, mor_pre, mor_post )
        
        if IsEndomorphism( cat, mor_pre ) then
            return MorphismDatum( cat, mor_pre ) = MorphismDatum( cat, mor_post );
        fi;
        
        return true;
        
    end );
    
    AddPreCompose( GrpCat,
      function( cat, mor_pre, mor_post )
        
        return MorphismConstructor( cat,
                       Source( mor_pre ),
                       MorphismDatum( cat, mor_pre ) * MorphismDatum( cat, mor_post ),
                       Range( mor_post ) );
        
    end );
    
    AddIdentityMorphism( GrpCat,
      function( cat, rx )
        
        return MorphismConstructor( cat,
                       rx,
                       One( UnderlyingFieldOfFractions( cat ) ),
                       rx );
        
    end );
    
    AddAdditionForMorphisms( GrpCat,
      function( cat, mor1, mor2 )
        
        return MorphismConstructor( cat,
                       Source( mor1 ),
                       MorphismDatum( cat, mor1 ) + MorphismDatum( cat, mor2 ),
                       Range( mor1 ) );
        
    end );
    
    AddAdditiveInverseForMorphisms( GrpCat,
      function( cat, mor )
        
        return MorphismConstructor( cat,
                       Source( mor ),
                       -MorphismDatum( cat, mor ),
                       Range( mor ) );
        
    end );
    
    AddZeroMorphism( GrpCat,
      function( cat, rx, ry )
        
        return MorphismConstructor( cat,
                       rx,
                       Zero( UnderlyingFieldOfFractions( cat ) ),
                       ry );
        
    end );
    
    AddMultiplyWithElementOfCommutativeRingForMorphisms( GrpCat,
      function( cat, f, mor )
        
        return MorphismConstructor( cat,
                       Source( mor ),
                       f * MorphismDatum( cat, mor ),
                       Range( mor ) );
        
    end );
    
    AddTensorUnit( GrpCat,
      function( cat )
        
        return ObjectConstructor( cat, One( UnderlyingMatrixGroup( cat ) ) );
        
    end );
    
    AddTensorProductOnObjects( GrpCat,
      function( cat, rx, ry )
        
        return ObjectConstructor( cat,
                       ObjectDatum( cat, rx ) * ObjectDatum( cat, ry ) );
        
    end );
    
    AddTensorProductOnMorphisms( GrpCat,
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
    
    AddBasisOfExternalHom( GrpCat,
      function( cat, rx, ry )
        
        if IsEqualForObjects( cat, rx, ry ) then
            return [ IdentityMorphism( cat, rx ) ];
        fi;
        
        return [ ];
        
    end );
    
    AddCoefficientsOfMorphism( GrpCat,
      function( cat, mor )
        
        if IsEqualForObjects( cat, Source( mor ), Range( mor ) ) then
            return [ MorphismDatum( cat, mor ) ];
        fi;
        
        return [ ];
        
    end );
    
    GrpCat!.compiler_hints :=
      rec( category_attribute_names :=
           [ "UnderlyingPreSheaf",
             "UnderlyingMatrixGroup",
             "UnderlyingRing",
             "UnderlyingFieldOfFractions",
             "UnderlyingTwistingRingMap",
             ] );
    
    Finalize( GrpCat );
    
    return GrpCat;
    
end );

##
InstallOtherMethod( GroupoidCategory,
        "for a homalg ring and a group",
        [ IsHomalgRing, IsMatrixGroup, IsList, IsList ],
        
  function( k, G, symbols, list_of_relations )
    local S, quiver, F, W, kW, PSh, kmat, Wo, Wg;
    
    S := _PrepareInputForPolynomialRing( k, symbols )[2];
    
    quiver := [ "q(o)[", JoinStringsWithSeparator( List( S, n -> Concatenation( n, ":o->o" ) ) ), "]" ];
    quiver := RightQuiver( Concatenation( quiver ) );
    
    F := FreeCategory( quiver );
    
    W := F / List( list_of_relations, rel -> [ F.(rel), F.o ] );
    
    kW := k[W];
    
    PSh := PreSheaves( kW );

    kmat := Target( PSh );
    
    Wo := [ Rank( One( G ) ) / kmat ];
    
    Wg := List( GeneratorsOfMagmaWithInverses( G ), mat -> mat / kmat );
    
    W := ObjectConstructor( PSh, Pair( Wo, Wg ) );
    
    SetUnderlyingMatrixGroup( W, G );
    
    return GroupoidCategory( W );
    
end );

##
InstallOtherMethod( QUO,
        "for a homalg ring and a group",
        [ IsMatrix, IsGroupoidCategory ],
        
  function( mat, GrpCat )
    
    return ObjectConstructor( GrpCat, mat );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( Display,
        "for an object in a groupoid category",
        [ IsObjectInGroupoidCategory ],
        
  function( obj )
    
    Display( ObjectDatum( obj ) );
    
end );

##
InstallMethod( Display,
        "for a morphism in a groupoid category",
        [ IsMorphismInGroupoidCategory ],
        
  function( obj )
    
    Print( MorphismDatum( obj ), "\n" );
    
end );
