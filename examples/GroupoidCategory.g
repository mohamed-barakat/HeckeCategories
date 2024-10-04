#! @Chunk GroupoidCategory

#! @Example
LoadPackage( "HeckeCategories", false );
#! true
G := Group( [[-1,1],[0,1]], [[1,0],[1,-1]] );
#! Group([ [ [ -1, 1 ], [ 0, 1 ] ], [ [ 1, 0 ], [ 1, -1 ] ] ])
Size( G );
#! 6
k := HomalgFieldOfRationalsInSingular( );
#! Q
GrpdCat := GroupoidCategory( k, G, "s,t", [ "ss", "tt", "ststst" ] );
#! GroupoidCategory( Q(a1,a2), W )
Display( GrpdCat );
#! A CAP category with name GroupoidCategory( Q(a1,a2), W ):
#! 
#! 20 primitive operations were used to derive 78 operations for this category
#! which algorithmically
#! * IsEquippedWithHomomorphismStructure
#! * IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
#! * IsMonoidalCategory
#! and furthermore mathematically
#! * IsStrictMonoidalCategory
presheaf := UnderlyingPreSheaf( GrpdCat );
#! <(o)->2; (s)->2x2, (t)->2x2>
IsWellDefined( presheaf );
#! true
Q := CommutativeRingOfLinearCategory( GrpdCat );
#! Q(a1,a2)
ExportVariables( Q );
#! [ a1, a2 ]
kW := UnderlyingGroupAlgebra( GrpdCat );
#! Algebra( Q, FreeCategory( RightQuiver( "q(o)[s:o->o,t:o->o]" ) ) )
#! / relations
rs := kW.s / GrpdCat;
#! <An object in GroupoidCategory( Q(a1,a2), W )>
IsWellDefined( rs );
#! true
Display( rs );
#! (o)-[{ 1*(s) }]->(o)
rt := kW.t / GrpdCat;
#! <An object in GroupoidCategory( Q(a1,a2), W )>
rs = rt;
#! false
rsy := TensorProduct( rs, rt );
#! <An object in GroupoidCategory( Q(a1,a2), W )>
Display( rsy );
#! (o)-[{ 1*(s*t) }]->(o)
id_x := IdentityMorphism( rs );
#! <An identity morphism in GroupoidCategory( Q(a1,a2), W )>
Display( id_x );
#! 1
phi_x := MorphismConstructor( rs, a1 * a2, rs );
#! <A morphism in GroupoidCategory( Q(a1,a2), W )>
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
psi_x := MorphismConstructor( rs, a2 * a1, rs );
#! <A morphism in GroupoidCategory( Q(a1,a2), W )>
phi_x = psi_x;
#! true
Display( phi_x - psi_x );
#! 0
Display( PreCompose( phi_x, psi_x ) );
#! (a1^2*a2^2)
phi_y := MorphismConstructor( rt, a2 * (a1-a2), rt );
#! <A morphism in GroupoidCategory( Q(a1,a2), W )>
phi_x = phi_y;
#! false
zero_st := ZeroMorphism( rs, rt );
#! <A zero morphism in GroupoidCategory( Q(a1,a2), W )>
Display( zero_st );
#! 0
zeta_st := MorphismConstructor( rs, a1 * a2, rt );
#! <A morphism in GroupoidCategory( Q(a1,a2), W )>
IsZero( zeta_st );
#! true
IsWellDefined( zeta_st );
#! false
eta_x := (a1-a2) * phi_x;
#! <A morphism in GroupoidCategory( Q(a1,a2), W )>
Display( eta_x );
#! (a1^2*a2-a1*a2^2)
end_x := BasisOfExternalHom( rs, rs );
#! [ <An identity morphism in GroupoidCategory( Q(a1,a2), W )> ]
Display( end_x[1] );
#! 1
CoefficientsOfMorphism( eta_x );
#! [ (a1^2*a2-a1*a2^2) ]
BasisOfExternalHom( rs, rt );
#! [ ]
CoefficientsOfMorphism( zeta_st );
#! [ ]
I := TensorUnit( GrpdCat );
#! <An object in GroupoidCategory( Q(a1,a2), W )>
Display( I );
#! (o)-[{ 1*(o) }]->(o)
chi_st := TensorProduct( phi_x, phi_y );
#! <A morphism in GroupoidCategory( Q(a1,a2), W )>
Display( chi_st );
#! (-a1^2*a2^2)
#! @EndExample
