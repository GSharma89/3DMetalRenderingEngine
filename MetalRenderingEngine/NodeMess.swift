//
//  NodeMess.swift
//  Solar System
//
//  Created by Gaurav Sharma on 26/07/17.
//  Copyright © 2017 Godrej Innovation Center. All rights reserved.
//

import Foundation
import MetalKit
class NodeMess
{
    var verticesBuffer:MTLBuffer!
    var indicesBuffer:MTLBuffer!
    var index_count:Int
    /*it will tell if number of instances is modified in current frame with respect to previous frame*/
    var prev_instance_count:Int32
    /*if same 3d object is used multiple times with different transfomation in node tree so then we only need to
     collect its vertices data only one time and need number of its instances so that same vertices data will be rendered
     as many times as number of instances*/
    var instance_count:Int32
    var nodeTransformArray = [matrix_float4x4]()
    var textureImagesArray:[String]
    /*a transform matrix is corresponding to an instance*/
    var nodeTransformPerInstanceBuffer:[Int: MTLBuffer]!
    /*a texture image is corresponding to an instance so we need to keep store them in this list*/
    var texturePerInstanceArray:[Int:MTLTexture]!
    var type:NodeType
    
    init(type:NodeType)
    {
        self.type = type
        instance_count = 0
        prev_instance_count = 0
        index_count = 0
        textureImagesArray = [String]()
        texturePerInstanceArray = [Int:MTLTexture]()
        nodeTransformPerInstanceBuffer = [Int: MTLBuffer]()
    }
    
}
