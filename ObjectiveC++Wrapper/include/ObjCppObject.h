//
//  ObjCppObject.h
//  MetalRenderingEngine
//
//  Created by Gaurav Sharma on 20/02/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

#ifndef ObjCppObject_h
#define ObjCppObject_h
#include "ObjCppDataType.h"
@interface ObjCppObject:NSObject
{
    NSString *obj_name;
    struct ObjCppVertex** vertex_list;
    size_t vertex_list_size;
}
- (void) addVertexAt:(int)i :(struct ObjCppVertex*)vert;
- (void) setObjectName:(NSString*)name;
- (struct ObjCppVertex*) getVertexAt:(int)i;
- (NSString*) getObjectName;
- (size_t) getVertexListSize;
- (void) setVertexListSize:(size_t)size;
- (void) dealloc;
@end

#endif /* ObjCppObject_h */
