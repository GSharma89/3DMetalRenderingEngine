//
//  ObjCppModel.m
//  MetalRenderingEngine
//
//  Created by Gaurav Sharma on 20/02/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjCppModel.h"
#import "ObjCppObject.h"
#import "Model.hpp"

@implementation ObjCppModel

-(void) setModelName:(NSString*) name
{
    self->model_name = name;
}
-(void) setObjectListSize:(size_t)s
{
    object_list_size = s;
    object_list = (ObjCppObject*__strong *)malloc(s*sizeof(ObjCppObject*));
}
-(void) setChildModelListSize:(size_t)s
{
    
    child_model_list_size = s;
    child_model_list = (ObjCppModel*__strong *)malloc(s*sizeof(ObjCppModel*));
}
-(size_t) getObjectListSize
{
    return object_list_size;
}
-(size_t) getChildModelListSize
{
    return child_model_list_size;
}

- (void) addObjectAt:(ObjCppObject*)obj : (int)i
{
    object_list[i] = obj;

}
- (ObjCppObject*) getObject:(int)i
{
    return object_list[i];
}
- (NSString*) getModelName
{
    return model_name;
}

- (void) addChildModelAt:(ObjCppModel*)model : (int)i
{
    child_model_list[i] = model;
}
- (ObjCppModel*) getChildModel:(int)i
{
    return child_model_list[i];
}
- (void) dealloc
{
    NSLog(@"ObjCppModel->dealloc is called");
    for(int i=0;i<object_list_size;i++)
    {
        ObjCppObject *obj = object_list[i];
        obj = nullptr;//deleted object
    }
    free(object_list);
    for(int i=0;i<child_model_list_size;i++)
    {
        child_model_list[i]=nullptr;//deleted
    }
    free(child_model_list);
}
@end
