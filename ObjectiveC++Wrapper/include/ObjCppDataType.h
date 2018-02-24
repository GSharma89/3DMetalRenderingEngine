//
//  ObjCppDataType.h
//  MetalRenderingEngine
//
//  Created by Gaurav Sharma on 20/02/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

#ifndef ObjCppDataType_h
#define ObjCppDataType_h
struct ObjCppPosition
{
    Float32 x;
    Float32 y;
    Float32 z;
    Float32 w;
};

struct ObjCppTexCoord
{
    Float32 u;
    Float32 v;
    Float32 w;
    Float32 t;
};
struct ObjCppNormal
{
    Float32 x;
    Float32 y;
    Float32 z;
    Float32 w;
};
struct ObjCppVertex
{
    struct ObjCppPosition *position;
    struct ObjCppNormal *normal;
    struct ObjCppTexCoord *texCoords;
    
    /*ObjCppVertex()
    {
        position = (ObjCppPosition*)malloc(sizeof(ObjCppPosition));
        normal = (ObjCppNormal*)malloc(sizeof(ObjCppNormal));
        texCoords = (ObjCppTexCoord*)malloc(sizeof(ObjCppTexCoord));
    }*/
    
};

#endif /* ObjCppDataType_h */
