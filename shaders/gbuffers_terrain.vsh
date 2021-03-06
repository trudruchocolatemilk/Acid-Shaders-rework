#version 120

varying vec4 color;
varying vec4 texcoord;
varying vec4 lmcoord;

attribute vec4 mc_Entity;

uniform int worldTime;
uniform int moonPhase;

void main() {

	int worldTrome = worldTime;

	worldTrome = worldTime + (24000 * moonPhase);

	texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;

	vec4 position = gl_ModelViewMatrix * gl_Vertex;
		
	float distanceSquared = position.x * position.x + position.z * position.z;
	position.x += sin(distanceSquared*sin(float(worldTrome)/(143.0 * 8))/1000);
	//position.z += sin(distanceSquared*sin(float(worldTrome)/(143.0 * 8))/1000);
	position.y += 8*sin(distanceSquared*sin(float(worldTrome)/(143.0 * 8))/2000);
		
	float y = position.y;
	float x = position.x;
	float z = position.z;
		
	float om = (sin(distanceSquared*sin(float(worldTrome)/131072.0)/5000) * sin(float(worldTrome)/400.0));
		
	position.y = x*sin(om)+y*cos(om);
	position.x = x*cos(om)-y*sin(om);
	position.z = z;

	gl_Position = gl_ProjectionMatrix * position; //Update position of matrix
	// color = vec4(sqrt(vec4(gl_Color))) + vec4((10/position.z) * (sin(position.x) * sin(z*2)), (10/position.z) * (sin(position.y) * cos(z)), (10/position.z) * (sin(position.z * sin(z * 2))), 0);
	color = gl_Color;

	lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
	
	gl_FogFragCoord = gl_Position.z;
}