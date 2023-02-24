#!
DeclareAttribute( "UnderlyingEnvelopingRing",
        IsStandardCategory );

CapJitAddTypeSignature( "UnderlyingEnvelopingRing", [ IsStandardCategory ], IsHomalgRing );

#!
DeclareAttribute( "UnderlyingEnvelopingTwistingRingMap",
        IsStandardCategory );

CapJitAddTypeSignature( "UnderlyingEnvelopingTwistingRingMap", [ IsStandardCategory ], IsHomalgRingMap );

vars_b, Re, phi_Re_R, 
    vars_b := Concatenation( "b1..", String( d ) );
    
    Re := R[vars_b];
    
    phi_Re_R :=
      function( w )
        local vars_a, phi;
        
        vars_a := Indeterminates( R );
        
        phi := Concatenation( vars_a, w * vars_a );
        
        return RingMap( phi, Re, R );
        
    end;
    
    SetUnderlyingEnvelopingRing( Std, Re );
    SetUnderlyingEnvelopingTwistingRingMap( Std, phi_Re_R );
    
             "UnderlyingEnvelopingRing",
             "UnderlyingEnvelopingTwistingRingMap",


Re := UnderlyingEnvelopingRing( Std );
#! Q[a1,a2,a3][b1,b2,b3]

eta_x := "a1*b1+a2*b3" / Re * phi_x;
#! <A morphism in StandardCategory( W, Q )>
Display( eta_x );
#! a1^2*a2^2+a1*a2^2*a3
