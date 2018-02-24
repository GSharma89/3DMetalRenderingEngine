
#include "ShaderDataTypes.h"
#include<simd/simd.h>
#include <metal_stdlib>
using namespace metal;

/*our vertex memory's size must be in multiple of 16 otherwise vertex_array in shader will not work with vertex_id*/
struct VertexInput
{
    simd::float4 position [[attribute(0)]];
    simd::float4 normal [[attribute(1)]];
    simd::float4 tex_cord [[attribute(2)]];
   
};

struct VertexOutput
{
    simd::float4 position [[position]];
    simd::float4 normal;
    simd::float4 tex_cord;
    uint texture_id;

};

constant float4 verts[] =
{
    float4(-1.0, 1.0, 0.0, 0.0),
    float4( 1.0, 1.0, 1.0, 0.0),
    float4(-1.0,-1.0, 0.0, 1.0),
    float4( 1.0,-1.0, 1.0, 1.0),
};

struct Varying
{
    float4 position [[position]];
    float2 tex_cord;
};

vertex Varying visualizeVertexShader(uint id [[vertex_id]])
{
    Varying vo;
    vo.position = float4(verts[id].xy,0.0,1.0);
    vo.tex_cord =float2(verts[id].z,verts[id].w);
    return vo;
};


fragment float4 visualizeFragmentShader(Varying vo [[stage_in]], texture2d<float,access::sample> texture [[texture(0)]],
                               sampler sampler2d [[sampler(0)]])
{
    
    float4 color;
    color = texture.sample(sampler2d,vo.tex_cord);
    
    return color;
}


vertex VertexOutput vertexShader( device VertexInput *vert_array [[buffer(0)]],constant Uniforms& uniform [[buffer(1)]],
                                  device matrix_float4x4 *model_matrix_array [[buffer(2)]],
                                  uint vid [[vertex_id]],
                                  uint iid [[instance_id]]
                                 )
{
    VertexOutput vo;
    VertexInput vert = vert_array[vid];
    matrix_float4x4 model_matrix = model_matrix_array[iid];
    vo.position = uniform.proj_matrix*uniform.view_matrix*model_matrix*float4(vert.position);
    vo.normal = model_matrix * float4(vert.normal);
    vo.tex_cord = vert.tex_cord;
    vo.texture_id = iid;
    
    return vo;
}

fragment half4 fragmentShader( VertexOutput vo [[stage_in]],const texture2d_array<float,access::sample> tex_array [[texture(0)]],
                              sampler samplr [[sampler(0)]])
    {

        
    
        float2 texCord = float2(vo.tex_cord.x,vo.tex_cord.y);
        half4 color = half4(tex_array.sample(samplr,texCord,vo.texture_id));
        //half4 color = half4(1,0,0,1);
    
        return color;
    }

