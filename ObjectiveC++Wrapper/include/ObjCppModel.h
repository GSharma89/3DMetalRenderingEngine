//
//  ObjCppModel.h
//  MetalRenderingEngine
//
//  Created by Gaurav Sharma on 20/02/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

#ifndef ObjCppModel_h
#define ObjCppModel_h
@class ObjCppObject;
@interface ObjCppModel:NSObject
{

    NSString* model_name;
    ObjCppObject *__strong *object_list;/*we can use here NSMutableArray like c++ vector*/
    ObjCppModel *__strong *child_model_list;
    size_t object_list_size;
    size_t child_model_list_size;
}
- (void) setModelName:(NSString*) name;
- (void) addObjectAt:(ObjCppObject*)obj : (int)i;
- (ObjCppObject*) getObject:(int)i;
- (void) addChildModelAt:(ObjCppModel*)model : (int)i;;
- (ObjCppModel*) getChildModel:(int)i;
- (NSString*) getModelName;
-(void) setObjectListSize:(size_t)s;
-(void) setChildModelListSize:(size_t)s;
-(size_t) getObjectListSize;
-(size_t) getChildModelListSize;
- (void) dealloc;
+ (void)initialize;
@end
#endif /* ObjCppModel_h */
