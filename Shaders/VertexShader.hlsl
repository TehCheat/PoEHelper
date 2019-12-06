///////////////////////
////   GLOBALS
///////////////////////
cbuffer ConstBuffer
{
	float2 windowSize;
};

//////////////////////
////   TYPES
//////////////////////
struct VertexInputType
{
	float2 position : POSITION;
	float2 tex : TEXCOORD;
	float4 color: COLOR;

};

struct PixelInputType
{
	float4 position : SV_POSITION;
	float4 color: COLOR0;
	float2 tex : TEXCOORD0;
};

/////////////////////////////////////
/////   Vertex Shader
/////////////////////////////////////
PixelInputType VS(VertexInputType input)
{
	PixelInputType output;


	// Calculate the position of the vertex monitor coord.
	output.position.x = 2.0f * (input.position.x) /(windowSize.x)-1;// (windowSize.x) - 1;
	output.position.y = -2.0f * (input.position.y) /(windowSize.y)+1;// (windowSize.y) +1;
	output.position.w = 1.0f;
	output.position.z = 1.0f;
    output.color = input.color;
	// Store the texture coordinates for the pixel shader to use.
	output.tex = input.tex;

	return output;
}
