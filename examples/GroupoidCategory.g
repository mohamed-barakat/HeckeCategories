#! @Chunk GroupoidCategory

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
Q := CommutativeRingOfLinearCategory( GrpdCat );
#! Q(a1,a2,a3)
ExportVariables( Q );
#! [ a1, a2, a3 ]
kW := UnderlyingGroupAlgebra( GrpdCat );
#! Algebra( Q, FreeCategory( RightQuiver( "q(o)[s:o->o,t:o->o]" ) ) )
#! / relations
rx := kW.s / GrpdCat;
#! <An object in GroupoidCategory( Q(a1,a2,a3), W )>
IsWellDefined( rx );
#! true
Display( rx );
#! (o)-[{ 1*(s) }]->(o)
ry := kW.t / GrpdCat;
#! <An object in GroupoidCategory( Q(a1,a2,a3), W )>
rx = ry;
#! false
rxy := TensorProduct( rx, ry );
#! <An object in GroupoidCategory( Q(a1,a2,a3), W )>
Display( rxy );
#! (o)-[{ 1*(s*t) }]->(o)
id_x := IdentityMorphism( rx );
#! <An identity morphism in GroupoidCategory( Q(a1,a2,a3), W )>
Display( id_x );
#! 1
phi_x := MorphismConstructor( rx, a1 * a2, rx );
#! <A morphism in GroupoidCategory( Q(a1,a2,a3), W )>
IsWellDefined( phi_x );
#! true
Display( phi_x );
#! (a1*a2)
IsOne( phi_x );
#! false
Display( 2 * a1 * phi_x );
#! (2*a1^2*a2)
Display( -phi_x );
#! (-a1*a2)
psi_x := MorphismConstructor( rx, a2 * a1, rx );
#! <A morphism in GroupoidCategory( Q(a1,a2,a3), W )>
phi_x = psi_x;
#! true
Display( phi_x - psi_x );
#! 0
Display( PreCompose( phi_x, psi_x ) );
#! (a1^2*a2^2)
phi_y := MorphismConstructor( ry, a2 * a3, ry );
#! <A morphism in GroupoidCategory( Q(a1,a2,a3), W )>
phi_x = phi_y;
#! false
zero_xy := ZeroMorphism( rx, ry );
#! <A zero morphism in GroupoidCategory( Q(a1,a2,a3), W )>
Display( zero_xy );
#! 0
zeta_xy := MorphismConstructor( rx, a1*a2, ry );
#! <A morphism in GroupoidCategory( Q(a1,a2,a3), W )>
IsZero( zeta_xy );
#! true
IsEqualForMorphisms( zero_xy, zeta_xy );
#! true
IsCongruentForMorphisms( zero_xy, zeta_xy );
#! true
eta_x := a3 * phi_x;
#! <A morphism in GroupoidCategory( Q(a1,a2,a3), W )>
Display( eta_x );
#! (a1*a2*a3)
end_x := BasisOfExternalHom( rx, rx );
#! [ <An identity morphism in GroupoidCategory( Q(a1,a2,a3), W )> ]
Display( end_x[1] );
#! 1
CoefficientsOfMorphism( eta_x );
#! [ (a1*a2*a3) ]
BasisOfExternalHom( rx, ry );
#! [ ]
CoefficientsOfMorphism( zeta_xy );
#! [ ]
I := TensorUnit( GrpdCat );
#! <An object in GroupoidCategory( Q(a1,a2,a3), W )>
Display( I );
#! (o)-[{ 1*(o) }]->(o)
chi_xy := TensorProduct( phi_x, phi_y );
#! <A morphism in GroupoidCategory( Q(a1,a2,a3), W )>
Display( chi_xy );
#! (a1^2*a2*a3)
#! @EndExample
