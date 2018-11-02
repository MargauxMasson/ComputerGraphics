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
	// gl_Position = gl_ModelViewProjectionMatrix *  gl_Vertex;

	vec3 vert = gl_Vertex.xyz;
	vert.x = gl_Vertex.x - vert.x*abs(sin(uTime*10))*uDistortion + vert.x*abs(cos(uTime*20))*uDistortion*fract(abs(sin(uTime*20))*uDistortion)*5;
	vert.y = gl_Vertex.y + cos(uTime*10)*uDistortion*fract(abs(sin(uTime))*uDistortion)*20;
	vert.z = gl_Vertex.z + cos(uTime)*uDistortion*fract(abs(sin(uTime))*uDistortion)*10;
	// vert.y = gl_Vertex.y - vert.x*(sin(uTime))*uDistortion + vert.x*abs(sin(uTime*20))*uDistortion*fract(abs(sin(uTime*20))*uDistortion);
	// vert.x = gl_Vertex.x + 2*abs(sin(1000*uTime*uDistortion))*fract(sin(dot(vec2(vert.y*abs(sin(1000*uTime*uDistortion)),vert.z*abs(sin(1000*uTime*uDistortion))),vec2(12.9898,78.233)))*43758.5453);
	// vert.y = gl_Vertex.y + abs(sin(uTime*20))*uDistortion + gl_Vertex.x*abs(cos(uTime*20))*uDistortion;
	// vert.z = gl_Vertex.z + abs(sin(uTime*20))*uDistortion + gl_Vertex.x*abs(cos(uTime*20))*uDistortion;
	gl_Position = gl_ModelViewProjectionMatrix * vec4( vert, 1. );
}