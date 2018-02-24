//
//  ShaderDataTypes.h
//
//  Created by Gaurav Sharma on 10/08/17.
//  Copyright © 2017 Godrej Innovation Center. All rights reserved.
//

#ifndef ShaderDataTypes_h
#define ShaderDataTypes_h
#include <simd/simd.h>
struct Uniforms
{
    matrix_float4x4 view_matrix;
    matrix_float4x4 proj_matrix;
};



#endif /* ShaderDataTypes_h */
