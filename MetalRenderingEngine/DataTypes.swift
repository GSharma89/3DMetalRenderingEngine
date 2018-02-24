//
//  DataTypes.swift
//  Solar System
//
//  Created by Gaurav Sharma on 10/08/17.
//  Copyright © 2017 Godrej Innovation Center. All rights reserved.
//


import simd
//always take vertex memory in the multiple of 16 bytes so that'why we have taken position,normal and texture 4 dimension coordinates
struct Uniforms
{
    var view_matrix:  matrix_float4x4
    var proj_matrix:  matrix_float4x4
    
    
    init() {
        
        
        
        view_matrix = matrix_identity_float4x4
        proj_matrix = matrix_identity_float4x4
    }
}

struct Vector4
{
    var x: Float32
    var y: Float32
    var z: Float32
    var w: Float32
}

/*struct TexCoords
{
    var u: Float32
    var v: Float32
    var w:Float32
    var t:Float32
}*/


struct Vertex
{
    var position: Vector4
    var normal: Vector4
    var texCoords: Vector4
    
}

//GRE-->Gaurav Rendering Engine
enum NodeType
{
    case GRE_PLANET
    
    case GRE_CUBE
    
    case GRE_RECT
    
    case GRE_GROUP
    /*node that already is in mess form so we need not to generate mess for that node.such nodes are loaded from .obj,.stl,
     .asm data exchange files*/
    case GRE_MESS
}

enum KeyBoardEventType
{
    case KEY_DOWN
    
    case KEY_UP
}

enum MouseEventType
{
    case MOUSE_LEFT_DOWN
    case MOUSE_LEFT_UP
    case MOUSE_RIGHT_DOWN
    case MOUSE_RIGHT_UP
    case MOUSE_MOVE
    
}
