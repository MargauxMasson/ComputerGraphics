#version 130 
out vec2 vST; // texture coords
out vec3 vN; // normal vector
out vec3 vL; // vector from point to light
out vec3 vE; // vector from point to eye
const vec3 LIGHTPOSITION = vec3( 5., 5., 0. );
uniform float uTime;
uniform float uDistortion;
uniform bool uAnimation;

void main( )
{
	vST = gl_MultiTexCoord0.st;

	vec4 ECposition = gl_ModelViewMatrix * gl_Vertex;
	vN = normalize( gl_NormalMatrix * gl_Normal ); // normal vector
	vL = LIGHTPOSITION - ECposition.xyz; // vector from the point
	// to the light position
	vE = vec3( 0., 0., 0. ) - ECposition.xyz; // vector from the point
	// to the eye position
	
	vec3 vert = gl_Vertex.xyz;
	// vert.x = vert.x + vert.x*5*uDistortion*sin(uTime) - vert.x*3*uDistortion*cos(uTime) + vert.z*abs(sin(1000*uTime*uDistortion));
	// vert.y =  vert.y + vert.x*5*uDistortion*sin(uTime) + vert.z*5*uDistortion*sin(uTime) ;
	vert.y = vert.y+2*abs(sin(1000*uTime*uDistortion))*fract(sin(dot(vec2(vert.x*abs(sin(1000*uTime*uDistortion)),vert.z*abs(sin(1000*uTime*uDistortion))),vec2(12.9898,78.233)))*43758.5453);

	// vert.z = vert.z + vert.z*5*uDistortion*sin(uTime) - vert.z*3*uDistortion*cos(uTime);

	gl_Position = gl_ModelViewProjectionMatrix * vec4( vert, 1. );
}