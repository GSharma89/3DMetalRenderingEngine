//
//  ModelLoaderWrapper.h
//  MetalRenderingEngine
//
//  Created by Gaurav Sharma on 19/02/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

#ifndef ObjCppModelLoader_h
#define ObjCppModelLoader_h
@class ObjCppModel;
#import <Foundation/Foundation.h>
@interface ObjCppModelLoader:NSObject
//- (Object*) getObject:(int)i;
- (ObjCppModel*) load:(NSString*)path;
- (void)dealloc;

@end
#endif /* ModelLoaderWrapper_h */
