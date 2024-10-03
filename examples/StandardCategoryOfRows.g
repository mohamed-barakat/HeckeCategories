#! @Chunk StandardCategoryOfRows

#! @Example
LoadPackage( "HeckeCategories", false );
#! true
G := Group( [[0,1,0],[1,0,0],[0,0,1]], [[1,0,0],[0,0,1],[0,1,0]] );
#! Group([ [ [ 0, 1, 0 ], [ 1, 0, 0 ], [ 0, 0, 1 ] ],
#!         [ [ 1, 0, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ] ] ])
k := HomalgFieldOfRationalsInSingular( );
#! Q
GrpdCat := GroupoidCategory( k, G, "s,t", [ "ss", "tt", "ststst" ] );
#! GroupoidCategory( Q(a1,a2,a3), W )
Display( GrpdCat );
#! A CAP category with name GroupoidCategory( Q(a1,a2,a3), W ):
#! 
#! 20 primitive operations were used to derive 78 operations for this category
#! which algorithmically
#! * IsEquippedWithHomomorphismStructure
#! * IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
#! * IsMonoidalCategory
#! and furthermore mathematically
#! * IsStrictMonoidalCategory
presheaf := UnderlyingPreSheaf( GrpdCat );
#! <(o)->3; (s)->3x3, (t)->3x3>
IsWellDefined( presheaf );
#! true
Q := CommutativeRingOfLinearCategory( GrpdCat );
#! Q(a1,a2,a3)
ExportVariables( Q );
#! [ a1, a2, a3 ]
kW := UnderlyingGroupAlgebra( GrpdCat );
#! Algebra( Q, FreeCategory( RightQuiver( "q(o)[s:o->o,t:o->o]" ) ) )
#! / relations
Std := StandardCategoryOfRows( presheaf );
#! StandardCategoryOfRows( Q(a1,a2,a3), W )
s := Pair( 1, [ kW.s ] ) / Std;
#! <An object in StandardCategoryOfRows( Q(a1,a2,a3), W )>
IsWellDefined( s );
#! true
t := Pair( 1, [ kW.t ] ) / Std;
#! <An object in StandardCategoryOfRows( Q(a1,a2,a3), W )>
IsWellDefined( t );
#! true
st := TensorProduct( s, t );
#! <An object in StandardCategoryOfRows( Q(a1,a2,a3), W )>
source_phi := DirectSum( [ st, s, st ] );
#! <An object in StandardCategoryOfRows( Q(a1,a2,a3), W )>
target_phi := DirectSum( [ st, s ] );
#! <An object in StandardCategoryOfRows( Q(a1,a2,a3), W )>
matrix_phi := HomalgMatrixListList( [ [ a1, 0 ], [ 0, a2 ], [ a3, 0 ] ], 3, 2, Q );
#! <A 3 x 2 matrix over an external ring>
phi := MorphismConstructor( source_phi, matrix_phi, target_phi );
#! <A morphism in StandardCategoryOfRows( Q(a1,a2,a3), W )>
IsWellDefined( phi );
#! true
source_psi := DirectSum( [ t, s ] );
#! <An object in StandardCategoryOfRows( Q(a1,a2,a3), W )>
target_psi := DirectSum( [ s, st ] );
#! <An object in StandardCategoryOfRows( Q(a1,a2,a3), W )>
matrix_psi := HomalgMatrixListList( [ [ 0, 0 ], [ a1 + a3, 0 ] ], 2, 2, Q );
#! <A 3 x 2 matrix over an external ring>
psi := MorphismConstructor( source_psi, matrix_psi, target_psi );
#! <A morphism in StandardCategoryOfRows( Q(a1,a2,a3), W )>
IsWellDefined( phi );
#! true

#! @EndExample
