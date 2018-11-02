#version 130 

uniform float uKa, uKd, uKs; // coefficients of each type of lighting
uniform vec3 uColor; // object color
uniform vec3 uSpecularColor; // light color
uniform float uShininess; // specular exponent
uniform float uSize; 
uniform float uTime; 
uniform float uPat; 
uniform float uS0;
uniform float uT0; 

in vec2 vST; // texture cords
in vec3 vN; // normal vector
in vec3 vL; // vector from point to light
in vec3 vE; // vector from point to eye

void main( ) {
	vec3 Normal = normalize(vN);
	vec3 Light = normalize(vL);
	vec3 Eye = normalize(vE);

	// vec3 ambient = uKa * uColor;

	vec3 myColor = uColor;
	// myColor = vec3( vST.t/10, vST.t/10, vST.t/10);
	myColor = vec3(uTime, uTime/10, 0.2);
	// if( uS0-uSize/2. <= vST.s && vST.s <= uS0+uSize/2. && uT0-uSize/2. <= vST.t && vST.t <= uT0+uSize/2. )
	// if(abs(sin(vST.s*100*uTime)) > 0.5 && abs(cos(vST.t*100*uTime)) > 0.5)
	// if(abs(sin(vST.s)) > 0.2 && abs(cos(vST.t)) > 0.2 && abs(cos(vST.t)) > 0.4 && abs(sin(vST.t)) > 0.4)
	// if(vST.t*uTime > 0.5 && vST.s*uTime < 0.5 && vST.s*uTime*10 > 0.5 && vST.t/10*uTime < 0.5)
	if(vST.t + fract(sin(uTime)) > 0.8 && vST.s + fract(sin(uTime)) > 0.8)
	{
		myColor = vec3( vST.s*uTime, vST.s*uTime, uTime );
	} 
	vec3 ambient = uKa * myColor;


	float d = max( dot(Normal,Light), 0. ); // only do diffuse if the light can see the point
	vec3 diffuse = uKd * d * uColor;
	float s = 0.;
	if( dot(Normal,Light) > 0. ) // only do specular if the light can see the point
	{
	vec3 ref = normalize( reflect( -Light, Normal ) );
	s = pow( max( dot(Eye,ref),0. ), uShininess );
	}
	vec3 specular = uKs * s * uSpecularColor;
	gl_FragColor = vec4( ambient + diffuse + specular, 1. );
}