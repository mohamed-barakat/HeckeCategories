# SPDX-License-Identifier: GPL-2.0-or-later
# HeckeCategories: Categorification of Hecke algebras
#
# Implementations
#

##
InstallOtherMethod( StandardCategoryOfRows,
        "for a presheaf",
        [ IsObjectInPreSheafCategory ],
        
  function( presheaf )
    local PSh, kW, W, GrpdCat, R, Q,
          object_datum_type, object_constructor, object_datum,
          morphism_datum_type, morphism_constructor, morphism_datum,
          AddGrpdCat,
          modeling_tower_object_constructor, modeling_tower_object_datum,
          modeling_tower_morphism_constructor, modeling_tower_morphism_datum,
          Std;
    
    PSh := CapCategory( presheaf );
    
    kW := Source( presheaf );
    
    W := UnderlyingCategory( kW );
    
    GrpdCat := GroupoidCategory( presheaf : FinalizeCategory := true );
    
    R := UnderlyingRing( GrpdCat );
    Q := CommutativeRingOfLinearCategory( GrpdCat );
    
    ##
    object_datum_type :=
      CapJitDataTypeOfNTupleOf( 2,
              IsBigInt,
              CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( kW ) ) );
    
    ##
    object_constructor :=
      function( Std, pair_of_int_and_list )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, Length( pair_of_int_and_list[2] ) = pair_of_int_and_list[1] );
        
        return CreateCapCategoryObjectWithAttributes( Std,
                       PairOfIntAndList, pair_of_int_and_list );
        
    end;
    
    ##
    object_datum := { Std, L } -> PairOfIntAndList( L );
    
    ##
    morphism_datum_type :=
      rec( filter := IsHomalgMatrix, ring := Q );
    
    ##
    morphism_constructor :=
      function ( Std, S, homalg_matrix, T )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsHomalgMatrix( homalg_matrix ) and
                IsIdenticalObj( HomalgRing( homalg_matrix ), CommutativeRingOfLinearCategory( Std ) ) and
                NumberRows( homalg_matrix ) = ObjectDatum( S )[1] and
                NumberColumns( homalg_matrix ) = ObjectDatum( T )[1] );
        
        return CreateCapCategoryMorphismWithAttributes( Std,
                       S,
                       T,
                       UnderlyingMatrix, homalg_matrix );
        
    end;
    
    ##
    morphism_datum := { Std, phi } -> UnderlyingMatrix( phi );
    
    ## building the categorical tower:
    
    #GrpdCat;
    
    AddGrpdCat := AdditiveClosure( GrpdCat : FinalizeCategory := true );
    
    ## the reinterpration of the tower:
    
    ## from the raw object data to the object in the modeling category
    modeling_tower_object_constructor :=
      function( Std, pair_of_int_and_list )
        local AddGrpdCat, GrpdCat;
        
        AddGrpdCat := ModelingCategory( Std );
        
        GrpdCat := UnderlyingCategory( AddGrpdCat );
        
        return ObjectConstructor( AddGrpdCat,
                       List( pair_of_int_and_list[2], mor ->
                             ObjectConstructor( GrpdCat, mor ) ) );
        
    end;
    
    ## from the object in the modeling category to the raw object data
    modeling_tower_object_datum :=
      function( Std, object_in_tower )
        local AddGrpdCat, GrpdCat, L;
        
        AddGrpdCat := ModelingCategory( Std );
        
        GrpdCat := UnderlyingCategory( AddGrpdCat );
        
        L := List( ObjectDatum( AddGrpdCat, object_in_tower ), o -> ObjectDatum( GrpdCat, o ) );
        
        return Pair( Length( L ), L );
        
    end;
    
    ## from the raw morphism data to the morphism in the modeling category
    modeling_tower_morphism_constructor :=
      function( Std, source, homalg_matrix, target )
        local GrpdCat, op_source, op_target, add_source, add_target, s, t;
        
        AddGrpdCat := ModelingCategory( Std );
        
        GrpdCat := UnderlyingCategory( AddGrpdCat );
        
        s := NumberRows( homalg_matrix );
        t := NumberColumns( homalg_matrix );
        
        add_source := ObjectDatum( AddGrpdCat, source );
        add_target := ObjectDatum( AddGrpdCat, target );
        
        return MorphismConstructor( AddGrpdCat,
                       source,
                       List( [ 1 .. s ], r ->
                             List( [ 1 .. t ], c ->
                                   MorphismConstructor( GrpdCat,
                                           add_source[r],
                                           homalg_matrix[r,c],
                                           add_target[c] ) ) ),
                       target );
        
    end;
    
    ## from the morphism in the modeling category to the raw morphism data
    modeling_tower_morphism_datum :=
      function( Std, phi )
        local AddGrpdCat, GrpdCat, add_source, add_target, s, t, phi_datum, matrix;
        
        AddGrpdCat := ModelingCategory( Std );
        
        GrpdCat := UnderlyingCategory( AddGrpdCat );
        
        Q := CommutativeRingOfLinearCategory( Std );
        
        add_source := Source( phi );
        add_target := Target( phi );
        
        s := Length( ObjectDatum( AddGrpdCat, add_source ) );
        t := Length( ObjectDatum( AddGrpdCat, add_target ) );
        
        phi_datum := MorphismDatum( AddGrpdCat, phi );
        
        matrix := List( [ 1 .. s ], r ->
                        List( [ 1 .. t ], c ->
                              MorphismDatum( GrpdCat, phi_datum[r,c] ) ) );
        
        return HomalgMatrixListList( matrix, s, t, Q );
        
    end;
    
    ##
    Std :=
      ReinterpretationOfCategory( AddGrpdCat,
              rec( name := Concatenation( "StandardCategoryOfRows( ", RingName( Q ), ", W )" ),
                   category_filter := IsStandardCategoryOfRows,
                   category_object_filter := IsObjectInStandardCategoryOfRows,
                   category_morphism_filter := IsMorphismInStandardCategoryOfRows,
                   object_datum_type := object_datum_type,
                   morphism_datum_type := morphism_datum_type,
                   object_constructor := object_constructor,
                   object_datum := object_datum,
                   morphism_constructor := morphism_constructor,
                   morphism_datum := morphism_datum,
                   modeling_tower_object_constructor := modeling_tower_object_constructor,
                   modeling_tower_object_datum := modeling_tower_object_datum,
                   modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
                   modeling_tower_morphism_datum := modeling_tower_morphism_datum,
                   only_primitive_operations := true )
              );
    
    SetUnderlyingPreSheaf( GrpdCat, presheaf );
    SetUnderlyingGroupAlgebra( GrpdCat, kW );
    SetUnderlyingGroup( GrpdCat, W );
    SetUnderlyingRing( GrpdCat, R );
    
    Append( Std!.compiler_hints.category_attribute_names,
            [ "UnderlyingPreSheaf",
              "UnderlyingGroupAlgebra",
              "UnderlyingGroup",
              "UnderlyingMatrixGroup",
              "UnderlyingRing",
             ] );
    
    return Std;
    
end );