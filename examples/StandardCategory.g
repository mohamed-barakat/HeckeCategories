#! @Chunk StandardCategory

#! @Example
LoadPackage( "HeckeCategories" );
#! true
W := Group( [[0,1,0],[1,0,0],[0,0,1]], [[1,0,0],[0,0,1],[0,1,0]] );
#! Group([ [ [ 0, 1, 0 ], [ 1, 0, 0 ], [ 0, 0, 1 ] ],
#!         [ [ 1, 0, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ] ] ])
k := HomalgFieldOfRationalsInSingular( );
#! Q
Std := StandardCategory( W, k );
#! StandardCategory( W, Q )
Display( Std );
#! A CAP category with name StandardCategory( W, Q ):
#! 
#! 20 primitive operations were used to derive 78 operations for this category
#! which algorithmically
#! * IsEquippedWithHomomorphismStructure
#! * IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
#! * IsMonoidalCategory
#! and furthermore mathematically
#! * IsStrictMonoidalCategory
Q := UnderlyingFieldOfFractions( Std );
#! Q(a1,a2,a3)
ExportVariables( Q );
#! [ a1, a2, a3 ]
x := [[0,1,0],[1,0,0],[0,0,1]];
#! [ [ 0, 1, 0 ], [ 1, 0, 0 ], [ 0, 0, 1 ] ]
rx := x / Std;
#! <An object in StandardCategory( W, Q )>
IsWellDefined( rx );
#! true
Display( rx );
#! [ [ 0, 1, 0 ],
#!   [ 1, 0, 0 ],
#!   [ 0, 0, 1 ] ]
y := [[1,0,0],[0,0,1],[0,1,0]];
#! [ [ 1, 0, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ] ]
ry := y / Std;
#! <An object in StandardCategory( W, Q )>
rx = ry;
#! false
z := [ [ 0, 1, 0 ], [ 1, 0, 0 ], [ 0, 0, 2 ] ];
#! [ [ 0, 1, 0 ], [ 1, 0, 0 ], [ 0, 0, 2 ] ]
IsWellDefined( z / Std );
#! false
rxy := TensorProduct( rx, ry );
#! <An object in StandardCategory( W, Q )>
Display( rxy );
#! [ [  0,  0,  1 ],
#!   [  1,  0,  0 ],
#!   [  0,  1,  0 ] ]
id_x := IdentityMorphism( rx );
#! <An identity morphism in StandardCategory( W, Q )>
Display( id_x );
#! 1
phi_x := MorphismConstructor( rx, a1 * a2, rx );
#! <A morphism in StandardCategory( W, Q )>
IsWellDefined( phi_x );
#! true
Display( phi_x );
#! a1*a2
IsOne( phi_x );
#! false
Display( 2 * a1 * phi_x );
#! 2*a1^2*a2
Display( -phi_x );
#! -a1*a2
psi_x := MorphismConstructor( rx, a2 * a1, rx );
#! <A morphism in StandardCategory( W, Q )>
phi_x = psi_x;
#! true
Display( phi_x - psi_x );
#! 0
Display( PreCompose( phi_x, psi_x ) );
#! a1^2*a2^2
phi_y := MorphismConstructor( ry, a2 * a3, ry );
#! <A morphism in StandardCategory( W, Q )>
phi_x = phi_y;
#! false
zero_xy := ZeroMorphism( rx, ry );
#! <A zero morphism in StandardCategory( W, Q )>
Display( zero_xy );
#! 0
zeta_xy := MorphismConstructor( rx, a1*a2, ry );
#! <A morphism in StandardCategory( W, Q )>
IsZero( zeta_xy );
#! true
IsEqualForMorphisms( zero_xy, zeta_xy );
#! true
IsCongruentForMorphisms( zero_xy, zeta_xy );
#! true
eta_x := a3 * phi_x;
#! <A morphism in StandardCategory( W, Q )>
Display( eta_x );
#! a1*a2*a3
end_x := BasisOfExternalHom( rx, rx );
#! [ <An identity morphism in StandardCategory( W, Q )> ]
Display( end_x[1] );
#! 1
CoefficientsOfMorphism( eta_x );
#! [ a1*a2*a3 ]
BasisOfExternalHom( rx, ry );
#! [ ]
CoefficientsOfMorphism( zeta_xy );
#! [ ]
I := TensorUnit( Std );
#! <An object in StandardCategory( W, Q )>
Display( I );
#! [ [ 1, 0, 0 ],
#!   [ 0, 1, 0 ],
#!   [ 0, 0, 1 ] ]
chi_xy := TensorProduct( phi_x, phi_y );
#! <A morphism in StandardCategory( W, Q )>
Display( chi_xy );
#! a1^2*a2*a3
#! @EndExample
