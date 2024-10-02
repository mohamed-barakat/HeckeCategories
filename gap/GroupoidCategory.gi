# SPDX-License-Identifier: GPL-2.0-or-later
# HeckeCategories: Categorification of Hecke algebras
#
# Implementations
#

InstallOtherMethod( GroupoidCategory,
        "for a presheaf",
        [ IsObjectInPreSheafCategory ],
        
  function( presheaf )
    local PSh, kW, W, presheaf_datum, d, vars_a, k, R, Q, phi, name, GrpdCat, V;
    
    PSh := CapCategory( presheaf );
    
    kW := Source( PSh );
    W := UnderlyingCategory( kW );
    
    presheaf_datum := ObjectDatum( presheaf );
    
    d := ObjectDatum( presheaf_datum[1][1] );
    
    vars_a := Concatenation( "a1..", String( d ) );
    
    k := CommutativeRingOfLinearCategory( PSh );
    R := k[vars_a];
    Q := HomalgFieldOfRationalsInSingular( vars_a, k );
    
    vars_a := HomalgMatrix( Indeterminates( R ), d, 1, R );
    
    phi :=
      function( w )
        local map;
        
        map := RingMap( R * UnderlyingMatrix( presheaf( w ) ) * vars_a, R, R );
        
        SetIsMorphism( map, true );
        
        return map;
        
    end;
    
    name := "W";
    
    name := Concatenation( "GroupoidCategory( ", RingName( Q ), ", ", name, " )" );
    
    GrpdCat := CreateCapCategory( name,
                      IsGroupoidCategory,
                      IsObjectInGroupoidCategory,
                      IsMorphismInGroupoidCategory,
                      IsCapCategoryTwoCell );
    
    SetUnderlyingPreSheaf( GrpdCat, presheaf );
    SetUnderlyingGroupAlgebra( GrpdCat, kW );
    SetUnderlyingGroup( GrpdCat, W );
    SetUnderlyingRing( GrpdCat, R );
    SetUnderlyingTwistingRingMap( GrpdCat, phi );
    
    GrpdCat!.category_as_first_argument := true;
    
    V := CategoryOfRows( R );
    
    SetIsAbCategory( GrpdCat, true );
    SetIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( GrpdCat, true );
    SetCommutativeRingOfLinearCategory( GrpdCat, Q );
    
    SetRangeCategoryOfHomomorphismStructure( GrpdCat, V );
    SetIsEquippedWithHomomorphismStructure( GrpdCat, true );
    
    SetIsStrictMonoidalCategory( GrpdCat, true );
    
    AddObjectConstructor( GrpdCat,
      function( GrpdCat, w )
        
        return CreateCapCategoryObjectWithAttributes( GrpdCat,
                       GroupElement, w );
        
    end );
    
    AddObjectDatum( GrpdCat,
      function( GrpdCat, obj )
        
        return GroupElement( obj );
        
    end );
    
    AddMorphismConstructor( GrpdCat,
      function( GrpdCat, source, ring_element, range )
        local datum;
        
        if IsEqualForObjects( GrpdCat, source, range ) then
            datum := ring_element;
        else
            datum := Zero( ring_element );
        fi;
        
        return CreateCapCategoryMorphismWithAttributes( GrpdCat,
                       source,
                       range,
                       UnderlyingRingElement, datum );
        
    end );
    
    AddMorphismDatum( GrpdCat,
      function( GrpdCat, obj )
        
        return UnderlyingRingElement( obj );
        
    end );
    
    AddIsWellDefinedForObjects( GrpdCat,
      function( GrpdCat, obj )
        
        return IsCapCategoryMorphism( ObjectDatum( GrpdCat, obj ) ) and
               IsIdenticalObj( CapCategory( ObjectDatum( GrpdCat, obj ) ), UnderlyingGroupAlgebra( GrpdCat ) );
        
    end );
    
    AddIsWellDefinedForMorphisms( GrpdCat,
      function( GrpdCat, mor )
        
        return MorphismDatum( GrpdCat, mor ) in CommutativeRingOfLinearCategory( GrpdCat );
        
    end );
    
    AddIsEqualForObjects( GrpdCat,
      function( GrpdCat, rx, ry )
        
        return IsCongruentForMorphisms( UnderlyingGroupAlgebra( GrpdCat ),
                       ObjectDatum( GrpdCat, rx ), ObjectDatum( GrpdCat, ry ) );
        
    end );
    
    AddIsEqualForMorphisms( GrpdCat,
      function( GrpdCat, mor_pre, mor_post )
        
        return MorphismDatum( GrpdCat, mor_pre ) = MorphismDatum( GrpdCat, mor_post );
        
    end );
    
    AddIsCongruentForMorphisms( GrpdCat,
      function( GrpdCat, mor_pre, mor_post )
        
        if IsEndomorphism( GrpdCat, mor_pre ) then
            return MorphismDatum( GrpdCat, mor_pre ) = MorphismDatum( GrpdCat, mor_post );
        fi;
        
        return true;
        
    end );
    
    AddPreCompose( GrpdCat,
      function( GrpdCat, mor_pre, mor_post )
        
        return MorphismConstructor( GrpdCat,
                       Source( mor_pre ),
                       MorphismDatum( GrpdCat, mor_pre ) * MorphismDatum( GrpdCat, mor_post ),
                       Range( mor_post ) );
        
    end );
    
    AddIdentityMorphism( GrpdCat,
      function( GrpdCat, rx )
        
        return MorphismConstructor( GrpdCat,
                       rx,
                       One( CommutativeRingOfLinearCategory( GrpdCat ) ),
                       rx );
        
    end );
    
    AddAdditionForMorphisms( GrpdCat,
      function( GrpdCat, mor1, mor2 )
        
        return MorphismConstructor( GrpdCat,
                       Source( mor1 ),
                       MorphismDatum( GrpdCat, mor1 ) + MorphismDatum( GrpdCat, mor2 ),
                       Range( mor1 ) );
        
    end );
    
    AddAdditiveInverseForMorphisms( GrpdCat,
      function( GrpdCat, mor )
        
        return MorphismConstructor( GrpdCat,
                       Source( mor ),
                       -MorphismDatum( GrpdCat, mor ),
                       Range( mor ) );
        
    end );
    
    AddZeroMorphism( GrpdCat,
      function( GrpdCat, rx, ry )
        
        return MorphismConstructor( GrpdCat,
                       rx,
                       Zero( CommutativeRingOfLinearCategory( GrpdCat ) ),
                       ry );
        
    end );
    
    AddMultiplyWithElementOfCommutativeRingForMorphisms( GrpdCat,
      function( GrpdCat, f, mor )
        
        return MorphismConstructor( GrpdCat,
                       Source( mor ),
                       f * MorphismDatum( GrpdCat, mor ),
                       Range( mor ) );
        
    end );
    
    AddTensorUnit( GrpdCat,
      function( GrpdCat )
        local W;
        
        W := UnderlyingGroupAlgebra( GrpdCat );
        
        return ObjectConstructor( GrpdCat, IdentityMorphism( W, SetOfObjects( W )[1] ) );
        
    end );
    
    AddTensorProductOnObjects( GrpdCat,
      function( GrpdCat, rx, ry )
        
        return ObjectConstructor( GrpdCat,
                       PreCompose( UnderlyingGroupAlgebra( GrpdCat ),
                               ObjectDatum( GrpdCat, rx ),
                               ObjectDatum( GrpdCat, ry ) ) );
        
    end );
    
    AddTensorProductOnMorphisms( GrpdCat,
      function( GrpdCat, mor1, mor2 )
        local kW, mor2_datum, phi_x, R, Q;
        
        kW := UnderlyingGroupAlgebra( GrpdCat );
        
        mor2_datum := MorphismDatum( GrpdCat, mor2 );
        
        phi_x := UnderlyingTwistingRingMap( GrpdCat )( InverseForMorphisms( kW, ObjectDatum( GrpdCat, Range( mor1 ) ) ) );
        
        R := UnderlyingRing( GrpdCat );
        Q := CommutativeRingOfLinearCategory( GrpdCat );
        
        return MorphismConstructor( GrpdCat,
                       TensorProductOnObjects( GrpdCat, Source( mor1 ), Source( mor2 ) ),
                       MorphismDatum( GrpdCat, mor1 ) * ( ( Pullback( phi_x, Numerator( mor2_datum ) / R ) / Q ) / ( Pullback( phi_x, Denominator( mor2_datum ) / R ) / Q ) ),
                       TensorProductOnObjects( GrpdCat, Range( mor1 ), Range( mor2 ) ) );
        
    end );
    
    AddBasisOfExternalHom( GrpdCat,
      function( GrpdCat, rx, ry )
        
        if IsEqualForObjects( GrpdCat, rx, ry ) then
            return [ IdentityMorphism( GrpdCat, rx ) ];
        fi;
        
        return [ ];
        
    end );
    
    AddCoefficientsOfMorphism( GrpdCat,
      function( GrpdCat, mor )
        
        if IsEqualForObjects( GrpdCat, Source( mor ), Range( mor ) ) then
            return [ MorphismDatum( GrpdCat, mor ) ];
        fi;
        
        return [ ];
        
    end );
    
    GrpdCat!.compiler_hints :=
      rec( category_attribute_names :=
           [ "UnderlyingPreSheaf",
             "UnderlyingGroupAlgebra",
             "UnderlyingGroup",
             "UnderlyingMatrixGroup",
             "UnderlyingRing",
             "UnderlyingTwistingRingMap",
             ] );
    
    Finalize( GrpdCat );
    
    return GrpdCat;
    
end );

##
InstallOtherMethod( GroupoidCategory,
        "for a homalg ring and a group",
        [ IsHomalgRing, IsMatrixGroup, IsList, IsList ],
        
  function( k, G, symbols, list_of_relations )
    local S, quiver, F, W, kW, PSh, kmat, presheaf;
    
    S := _PrepareInputForPolynomialRing( k, symbols )[2];
    
    quiver := [ "q(o)[", JoinStringsWithSeparator( List( S, n -> Concatenation( n, ":o->o" ) ) ), "]" ];
    quiver := RightQuiver( Concatenation( quiver ) );
    
    F := FreeCategory( quiver );
    
    W := F / List( list_of_relations, rel -> [ F.(rel), F.o ] );
    
    kW := k[W];
    
    PSh := PreSheaves( kW );
    
    kmat := Target( PSh );
    
    presheaf := ObjectConstructor( PSh,
                        Pair( ## on the single object
                              [ Rank( One( G ) ) / kmat ],
                              ## on morphisms
                              List( GeneratorsOfMagmaWithInverses( G ), mat -> mat / kmat ) ) );
    
    SetUnderlyingMatrixGroup( presheaf, G );
    
    return GroupoidCategory( presheaf );
    
end );

##
InstallOtherMethod( QUO,
        "for a homalg ring and a group",
        [ IsMatrix, IsGroupoidCategory ],
        
  function( mat, GrpdCat )
    
    return ObjectConstructor( GrpdCat, mat );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( DisplayString,
        "for an object in a groupoid category",
        [ IsObjectInGroupoidCategory ],
        
  function( obj )
    
    return Concatenation( StringView( ObjectDatum( obj ) ), "\n" );
    
end );

##
InstallMethod( Display,
        "for a morphism in a groupoid category",
        [ IsMorphismInGroupoidCategory ],
        
  function( obj )
    
    Print( MorphismDatum( obj ), "\n" );
    
end );
