//////////////////////
////   GLOBALS
//////////////////////
Texture2D shaderTexture;
SamplerState SampleType;

//////////////////////
////   TYPEDEFS
//////////////////////
struct PixelInputType
{
	float4 position : SV_POSITION;
	float4 color: COLOR0;
	float2 tex : TEXCOORD0;
	
};

//////////////////////
////   Pixel Shader
/////////////////////
float4 PS(PixelInputType input) : SV_TARGET
{
	float4 textureColor;

// Sample the pixel color from the texture using the sampler at this texture coordinate location.
textureColor = input.color * shaderTexture.Sample(SampleType, input.tex);
//return input.color;

return textureColor;
}
