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
#! 20 primitive operations were used to derive 79 operations for this category
#! which algorithmically
#! * IsEquippedWithHomomorphismStructure
#! * IsLinearCategoryOverCommutativeRing
#! * IsMonoidalCategory
#! and furthermore mathematically
#! * IsStrictMonoidalCategory
R := UnderlyingRing( Std );
#! Q[a1,a2,a3]
ExportVariables( R );
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
psi_x := MorphismConstructor( rx, a2 * a1, rx );
#! <A morphism in StandardCategory( W, Q )>
phi_x = psi_x;
#! true
Display( PreCompose( phi_x, psi_x ) );
#! a1^2*a2^2
phi_y := MorphismConstructor( ry, a2 * a3, ry );
#! <A morphism in StandardCategory( W, Q )>
phi_x = phi_y;
#! false
zeta_xy := ZeroMorphism( rx, ry );
#! <A zero morphism in StandardCategory( W, Q )>
Display( zeta_xy );
#! 0
zeta_xy = MorphismConstructor( rx, a1*a2, ry );
#! true
eta_x := a3 * phi_x;
#! <A morphism in StandardCategory( W, Q )>
Display( eta_x );
#! a1*a2*a3
chi_xy := TensorProduct( phi_x, phi_y );
#! <A morphism in StandardCategory( W, Q )>
Display( chi_xy );
#! a1^2*a2*a3
#! @EndExample
