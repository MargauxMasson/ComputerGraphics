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
	// vert.x = gl_Vertex.x - vert.x*abs(sin(uTime*10))*uDistortion + vert.x*abs(cos(uTime*20))*uDistortion*fract(abs(sin(uTime*20))*uDistortion);
	// vert.y = gl_Vertex.y + cos(uTime*10)*uDistortion*fract(abs(sin(uTime))*uDistortion)*10;
	// vert.z = vert.z + cos(uTime)*uDistortion*fract(abs(sin(uTime))*uDistortion)*5;

	// vert.x = vert.x + vert.z*abs(sin(1000*uTime*uDistortion))+ vert.z*abs(sin(1000*uTime*uDistortion))/10;
	// vert.y =  vert.y + cos(uTime*10)*uDistortion*fract(abs(sin(uTime))*uDistortion)*10 + uDistortion*vert.y + vert.x*abs(sin(1000*uTime*uDistortion));
	// vert.z = vert.z + vert.x*abs(sin(1000*uTime*uDistortion)) + cos(uTime)*uDistortion*fract(abs(sin(uTime))*uDistortion)*5;
	vert.x = vert.x + vert.x*5*uDistortion*sin(uTime) - vert.x*3*uDistortion*cos(uTime) + vert.z*abs(sin(1000*uTime*uDistortion));
	vert.y =  vert.y + vert.y*5*uDistortion*sin(uTime) - vert.y*3*uDistortion*cos(uTime);
	vert.z = vert.z + vert.z*5*uDistortion*sin(uTime) - vert.z*3*uDistortion*cos(uTime);

	gl_Position = gl_ModelViewProjectionMatrix * vec4( vert, 1. );
}