#version 130 

uniform float uKa, uKd, uKs; // coefficients of each type of lighting
uniform vec3 uColor; // object color
uniform vec3 uSpecularColor; // light color
uniform float uShininess; // specular exponent
uniform bool uAnimation;
uniform float uDistortion;
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

	vec3 myColor = uColor;
	if(uAnimation && vST.t + fract(sin(uTime)) > 0.8 && vST.s + fract(sin(uTime)) > 0.8)
	{
		myColor = vec3(uTime, uTime/10, 0.2);
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