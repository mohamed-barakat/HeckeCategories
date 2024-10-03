# SPDX-License-Identifier: GPL-2.0-or-later
# HeckeCategories: Categorification of Hecke algebras
#
# Implementations
#

##
InstallOtherMethod( StandardCategoryOfColumns,
        "for a presheaf",
        [ IsObjectInPreSheafCategory ],
        
  function( presheaf )
    local PSh, kW, W, GrpdCat, R, Q,
          object_datum_type, object_constructor, object_datum,
          morphism_datum_type, morphism_constructor, morphism_datum,
          StdRows, opStdRows,
          modeling_tower_object_constructor, modeling_tower_object_datum,
          modeling_tower_morphism_constructor, modeling_tower_morphism_datum,
          StdCols;
    
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
      function( StdCols, pair_of_int_and_list )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, Length( pair_of_int_and_list[2] ) = pair_of_int_and_list[1] );
        
        return CreateCapCategoryObjectWithAttributes( StdCols,
                       PairOfIntAndList, pair_of_int_and_list );
        
    end;
    
    ##
    object_datum := { StdCols, L } -> PairOfIntAndList( L );
    
    ##
    morphism_datum_type :=
      rec( filter := IsHomalgMatrix, ring := Q );
    
    ##
    morphism_constructor :=
      function ( StdCols, S, homalg_matrix, T )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsHomalgMatrix( homalg_matrix ) and
                IsIdenticalObj( HomalgRing( homalg_matrix ), CommutativeRingOfLinearCategory( StdCols ) ) and
                NumberColumns( homalg_matrix ) = ObjectDatum( S )[1] and
                NumberRows( homalg_matrix ) = ObjectDatum( T )[1] );
        
        return CreateCapCategoryMorphismWithAttributes( StdCols,
                       S,
                       T,
                       UnderlyingMatrix, homalg_matrix );
        
    end;
    
    ##
    morphism_datum := { StdCols, phi } -> UnderlyingMatrix( phi );
    
    ## building the categorical tower:
    
    StdRows := StandardCategoryOfRows( presheaf : FinalizeCategory := true );
    
    opStdRows := Opposite( StdRows : only_primitive_operations_and_hom_structure := true, FinalizeCategory := true );
    
    ## the reinterpration of the tower:
    
    ## from the raw object data to the object in the modeling category
    modeling_tower_object_constructor :=
      function( StdCols, pair_of_int_and_list )
        local opStdRows, StdRows;
        
        opStdRows := ModelingCategory( StdCols );
        
        StdRows := OppositeCategory( opStdRows );
        
        return ObjectConstructor( opStdRows,
                       ObjectConstructor( StdRows,
                               pair_of_int_and_list ) );
        
    end;
    
    ## from the object in the modeling category to the raw object data
    modeling_tower_object_datum :=
      function( StdCols, object_in_tower )
        local opStdRows, StdRows;
        
        opStdRows := ModelingCategory( StdCols );
        
        StdRows := OppositeCategory( opStdRows );
        
        return ObjectDatum( StdRows,
                       ObjectDatum( opStdRows,
                               object_in_tower ) );
        
    end;
    
    ## from the raw morphism data to the morphism in the modeling category
    modeling_tower_morphism_constructor :=
      function( StdCols, source, homalg_matrix, target )
        local opStdRows, StdRows;
        
        opStdRows := ModelingCategory( StdCols );
        
        StdRows := OppositeCategory( opStdRows );
        
        return MorphismConstructor( opStdRows,
                       source,
                       MorphismConstructor( StdRows,
                               ObjectDatum( opStdRows, target ),
                               homalg_matrix,
                               ObjectDatum( opStdRows, source ) ),
                       target );
        
    end;
    
    ## from the morphism in the modeling category to the raw morphism data
    modeling_tower_morphism_datum :=
      function( StdCols, morphism_in_tower )
        local opStdRows, StdRows;
        
        opStdRows := ModelingCategory( StdCols );
        
        StdRows := OppositeCategory( opStdRows );
        
        return MorphismDatum( StdRows,
                       MorphismDatum( opStdRows,
                               morphism_in_tower ) );
        
    end;
    
    ##
    StdCols :=
      ReinterpretationOfCategory( opStdRows,
              rec( name := Concatenation( "StandardCategoryOfColumns( ", RingName( Q ), ", W )" ),
                   category_filter := IsStandardCategoryOfColumns,
                   category_object_filter := IsObjectInStandardCategoryOfColumns,
                   category_morphism_filter := IsMorphismInStandardCategoryOfColumns,
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
    
    Append( StdCols!.compiler_hints.category_attribute_names,
            [ "UnderlyingPreSheaf",
              "UnderlyingGroupAlgebra",
              "UnderlyingGroup",
              "UnderlyingMatrixGroup",
              "UnderlyingRing",
             ] );
    
    return StdCols;
    
end );
