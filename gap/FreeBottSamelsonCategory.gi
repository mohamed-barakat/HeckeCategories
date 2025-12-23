# SPDX-License-Identifier: GPL-2.0-or-later
# HeckeCategories: Categorification of Hecke algebras
#
# Implementations
#

##
InstallOtherMethod( FreeBottSamelsonCategory,
        "for a matrix of integers",
        [ IsMatrix, IsList ],
        
  function( coxeter_matrix, colors )
    local r, generators, dots, trivalents, FinQuivers, s, t, base_quiver, DecoratedFinQuivers,
          object_datum_type, object_constructor, object_datum,
          morphism_datum_type, morphism_constructor, morphism_datum,
          modeling_tower_object_constructor, modeling_tower_object_datum,
          modeling_tower_morphism_constructor, modeling_tower_morphism_datum,
          FreeBS;
    
    r := NumberRows( coxeter_matrix );

    Assert( 0, r = NumberColumns( coxeter_matrix ) );
    
    ##
    object_datum_type :=
      CapJitDataTypeOfListOf( IsBigInt );
    
    ##
    object_constructor :=
      function( FreeBS, list_of_ints )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, ForAll( list_of_ints, IsBigInt ) );
        
        return CreateCapCategoryObjectWithAttributes( FreeBS,
                       ListOfInts, list_of_ints );
        
    end;
    
    ##
    object_datum := { FreeBS, obj } -> ListOfInts( obj );
    
    ##
    morphism_datum_type :=
      CapJitDataTypeOfListOf( CapJitDataTypeOfListOf( Pair( CapJitDataTypeOfListOf( IsBigInt ), CapJitDataTypeOfListOf( IsBigInt ) ) ) );

      #[ [ [ [ 0 ], [ 0, 0 ] ],     [ [ 0 ], [ ] ]  ],
      #  ... ]
    
      #LHS := &*[
      #Braid(B, r, g) cat [b, r, g],
      #[r, g] cat Braid(B, b, r) cat [g],
      #[r] cat Braid(B, b, g) cat [r] cat Braid(B, g, b),
      #[r, b] cat Braid(B, r, g) cat [b],
      #Braid(B, b, r) cat [g, r, b],
      #[b, r] cat Braid(B, g, b) cat [r, b]
      #];
      
    ##
    morphism_constructor :=
      function ( StdRows, S, homalg_matrix, T )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsHomalgMatrix( homalg_matrix ) and
                IsIdenticalObj( HomalgRing( homalg_matrix ), CommutativeRingOfLinearCategory( StdRows ) ) and
                NumberRows( homalg_matrix ) = ObjectDatum( S )[1] and
                NumberColumns( homalg_matrix ) = ObjectDatum( T )[1] );
        
        return CreateCapCategoryMorphismWithAttributes( StdRows,
                       S,
                       T,
                       UnderlyingMatrix, homalg_matrix );
        
    end;
    
    ##
    morphism_datum := { StdRows, phi } -> UnderlyingMatrix( phi );
    
    ## building the categorical tower:
    
    generators := [ 0 .. r - 1 ];
    dots := r + [ 0 .. r - 1 ];
    trivalents := 2 * r + [ 0 .. r - 1 ];
    
    FinQuivers := CategoryOfQuiversEnrichedOver( SkeletalFinSets : FinalizeCategory := true );
    
    s := Concatenation( List( [ 0 .. r - 1 ], i -> [ i, i ] ) );
    s := Concatenation( s,
                 Concatenation( List( [ 0 .. r - 1 ], i -> ListWithIdenticalEntries( r - 1, i ) ) ) );
    
    t := r + Concatenation( List( [ 0 .. r - 1 ], i -> i + [ 0, r ] ) );
    t := Concatenation( t,
                 3 * r + Concatenation( List( [ 0 .. r - 1 ], i ->
                         -1 + PositionsProperty( Concatenation( List( [ 0 .. r - 2 ], i -> List( [ i + 1 .. r - 1 ], j -> [ i, j ] ) ) ), p -> i in p ) ) ) );
    
    ## triangles, dots and stars
    base_quiver :=
      CreateQuiver( FinQuivers,
              3 * r + Binomial( r, 2 ), ## generators, stars, dots, triangles: S + S + S + ( S choose 2 )
              TransposedMat( [ s, t ] ) );

    
    DecoratedFinQuivers := CategoryOfDecoratedQuivers( base_quiver,
                                   Concatenation(
                                           colors, ## generators
                                           colors, ## dots
                                           colors, ## trivalents
                                           ListWithIdenticalEntries( Binomial( r, 2 ), "black" ) ), ## stars
                                   colors{1 + s} );

    ## Cospans ...
    ## Subcategory ... 
    
    Error( );
    
    ## the reinterpration of the tower:
    
    ## from the raw object data to the object in the modeling category
    modeling_tower_object_constructor :=
      function( FreeBS, pair_of_int_and_list )
        local AddGrpdCat, GrpdCat;
        
        AddGrpdCat := ModelingCategory( FreeBS );
        
        GrpdCat := UnderlyingCategory( AddGrpdCat );
        
        return ObjectConstructor( AddGrpdCat,
                       List( pair_of_int_and_list[2], mor ->
                             ObjectConstructor( GrpdCat, mor ) ) );
        
    end;
    
    ## from the object in the modeling category to the raw object data
    modeling_tower_object_datum :=
      function( FreeBS, object_in_tower )
        local AddGrpdCat, GrpdCat, L;
        
        AddGrpdCat := ModelingCategory( FreeBS );
        
        GrpdCat := UnderlyingCategory( AddGrpdCat );
        
        L := List( ObjectDatum( AddGrpdCat, object_in_tower ), o -> ObjectDatum( GrpdCat, o ) );
        
        return Pair( Length( L ), L );
        
    end;
    
    ## from the raw morphism data to the morphism in the modeling category
    modeling_tower_morphism_constructor :=
      function( FreeBS, source, homalg_matrix, target )
        local AddGrpdCat, GrpdCat, op_source, op_target, add_source, add_target, s, t;
        
        AddGrpdCat := ModelingCategory( FreeBS );
        
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
      function( FreeBS, morphism_in_tower )
        local AddGrpdCat, GrpdCat, Q, add_source, add_target, s, t, morphism_in_tower_datum, matrix;
        
        AddGrpdCat := ModelingCategory( FreeBS );
        
        GrpdCat := UnderlyingCategory( AddGrpdCat );
        
        Q := CommutativeRingOfLinearCategory( FreeBS );
        
        add_source := Source( morphism_in_tower );
        add_target := Target( morphism_in_tower );
        
        s := Length( ObjectDatum( AddGrpdCat, add_source ) );
        t := Length( ObjectDatum( AddGrpdCat, add_target ) );
        
        morphism_in_tower_datum := MorphismDatum( AddGrpdCat, morphism_in_tower );
        
        matrix := List( [ 1 .. s ], r ->
                        List( [ 1 .. t ], c ->
                              MorphismDatum( GrpdCat, morphism_in_tower_datum[r,c] ) ) );
        
        return HomalgMatrixListList( matrix, s, t, Q );
        
    end;
    
    ##
    FreeBS :=
      ReinterpretationOfCategory( DecoratedFinQuivers,
              rec( name := Concatenation( "FreeBottSamelsonCategory( coxeter_matrix )" ),
                   category_filter := IsFreeBottSamelsonCategory,
                   category_object_filter := IsObjectInFreeBottSamelsonCategory,
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
    
    SetUnderlyingCoxeterMatrix( FreeBS, coxeter_matrix );
    
    Append( FreeBS!.compiler_hints.category_attribute_names,
            [ "UnderlyingCoxeterMatrix",
             ] );
    
    return FreeBS;
    
end );
