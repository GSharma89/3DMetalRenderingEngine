//
//  ObjCppObject.m
//  MetalRenderingEngine
//
//  Created by Gaurav Sharma on 20/02/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjCppObject.h"

@implementation ObjCppObject
- (void) addVertexAt:(int)i :(struct ObjCppVertex*)vert
{
    vertex_list[i] = vert;
}
- (void) setObjectName:(NSString*)name
{
    obj_name = name;
}
- (struct ObjCppVertex*) getVertexAt:(int)i
{
    return vertex_list[i];
}
- (NSString*) getObjectName
{
    return obj_name;
}
- (size_t) getVertexListSize
{
    return vertex_list_size;
}
- (void) setVertexListSize:(size_t)size
{
    //it is the case when in any frame we need to load again data then we have to clear previous list from memory.
    if(vertex_list != NULL)
    {
        for (int i=0; i<vertex_list_size; i++)
        {
            struct ObjCppVertex *vert = vertex_list[i];
            free(vert->position);
            free(vert->normal);
            //free(vert->lightCoords);
            free(vert->texCoords);
            free(vert);
        }
    }
    vertex_list_size  = size;
    printf("\nsize of vertex list in ObjCppObject:%zu",vertex_list_size);
    
    vertex_list  = (struct ObjCppVertex**)malloc(vertex_list_size*sizeof(struct ObjCppVertex*));
}
- (void) dealloc
{
    printf("\n ObjCppObject->dealloc is called");
    for (int i=0; i<vertex_list_size; i++)
    {
        struct ObjCppVertex *vert = vertex_list[i];
        free(vert->position);
        free(vert->normal);
        free(vert->texCoords);
        free(vert);
    }
}
@end
