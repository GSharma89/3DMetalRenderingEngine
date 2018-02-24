//
//  ModelLoaderWrapper.m
//  MetalRenderingEngine
//
//  Created by Gaurav Sharma on 19/02/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjCppModelLoader.h"

#include "DataType.h"
#include "ModelLoader.h"
#include "Model.hpp"
#include "Object.hpp"
#include "ObjCppModel.h"
#include "ObjCppObject.h"
//@interface ObjCppModelLoader()
//@end

void copyObjectInObjCppObject(Object* source_obj,ObjCppObject* target_obj)
{
    
    
    size_t  num_elements = source_obj->getNumberOfElements();
    for (int i=0; i<source_obj->getNumberOfSmoothingGroups(); i++)
    {
        SmoothingGroup *sm_grp = source_obj->getSmoothingGroup(i);
        num_elements = num_elements+sm_grp->element_list.size();
    }
    
    //allocating memory 3 times of number of elements because one element is triangle so it has three vertices
    [target_obj setVertexListSize:3*num_elements];
    
    for (int j=0; j<source_obj->getNumberOfElements(); j++)
    {
        PolygonGeometry* geom = (PolygonGeometry*)source_obj->getElement(j);
        if(geom->getType() == GL_TRIANGLE)
        {
            
            for(int k=0;k<3;k++)
            {
                //this is the target structure where data is to be stored
                struct ObjCppVertex *obj_cpp_vert = (ObjCppVertex *)geom->getVertexAt(k);
                
                /*printf("\n Position:");
                printf("\n%f %f %f",obj_cpp_vert->position->x);
                printf("\n%f %f %f",obj_cpp_vert->position->y);
                printf("\n%f %f %f",obj_cpp_vert->position->z);
                printf("\n%f %f %f",obj_cpp_vert->position->w);
                
                printf("\n Normal:");
                printf("\n%f %f %f",obj_cpp_vert->normal->x);
                printf("\n%f %f %f",obj_cpp_vert->normal->y);
                printf("\n%f %f %f",obj_cpp_vert->normal->z);
                
                printf("\n TexCord:");
                printf("\n%f %f %f",obj_cpp_vert->texCoords->u);
                printf("\n%f %f %f",obj_cpp_vert->texCoords->v);
                printf("\n%f %f %f",obj_cpp_vert->texCoords->w);*/
                
                [target_obj addVertexAt:(3*j+k) :obj_cpp_vert];
                
                
                //(struct ObjCppVertex *)malloc(sizeof(struct ObjCppVertex));
                //this is destination vertex from where data is to be taken
                /*Vertex *vert = geom->getVertexAt(k);
                 
                 obj_cpp_vert->position = (ObjCppPosition*)vert->postion;
                 obj_cpp_vert->normal = (ObjCppNormal*)vert->normal;//(ObjCppNormal*)malloc(sizeof(ObjCppNormal));
                 obj_cpp_vert->texCoords = (ObjCppTexCoord*)vert->tex_cord;//(ObjCppTexCoord*)malloc(sizeof(ObjCppTexCoord));*/
                
                
            }
            
        }
    }
    
    for(int i=0;i<source_obj->getNumberOfSmoothingGroups();i++)
    {
        SmoothingGroup *smth_grp = source_obj->getSmoothingGroup(i);
        /*it is because that these are the elements which already we copied in above loop.here now we are copying all
         elements in all smoothig group of source object in same vertex list of target object as above we have used*/
        size_t num_element_in_source_obj = source_obj->getNumberOfElements();
        //printf("\nsize of element list in source obj%zut:%zu",num_element_in_source_obj);
        size_t num_element_in_smooth_group = smth_grp->element_list.size();
        //printf("\nsize of element list in smooth gr%zup:%u",num_element_in_smooth_group);
        for (int j=0; j<num_element_in_smooth_group; j++)
        {
            
            PolygonGeometry* geom = (PolygonGeometry*)smth_grp->element_list.at(j);
            if(geom->getType() == GL_TRIANGLE)
            {
            
                for(int k=0;k<3;k++)
                {
                    //this is the target structure where data is to be stored
                    struct ObjCppVertex *obj_cpp_vert = (ObjCppVertex *)geom->getVertexAt(k);
                
                    /*printf("\n Position:");
                    printf("\n%f %f %f",obj_cpp_vert->position->x);
                    printf("\n%f %f %f",obj_cpp_vert->position->y);
                    printf("\n%f %f %f",obj_cpp_vert->position->z);
                    printf("\n%f %f %f",obj_cpp_vert->position->w);
                
                    printf("\n Normal:");
                    printf("\n%f %f %f",obj_cpp_vert->normal->x);
                    printf("\n%f %f %f",obj_cpp_vert->normal->y);
                    printf("\n%f %f %f",obj_cpp_vert->normal->z);
                
                    printf("\n TexCord:");
                    printf("\n%f %f %f",obj_cpp_vert->texCoords->u);
                    printf("\n%f %f %f",obj_cpp_vert->texCoords->v);
                    printf("\n%f %f %f",obj_cpp_vert->texCoords->w);*/
                
                    [target_obj addVertexAt:(3*j+k+num_element_in_source_obj) :obj_cpp_vert];
                
                
                    //(struct ObjCppVertex *)malloc(sizeof(struct ObjCppVertex));
                    //this is destination vertex from where data is to be taken
                    /*Vertex *vert = geom->getVertexAt(k);
                 
                     obj_cpp_vert->position = (ObjCppPosition*)vert->postion;
                     obj_cpp_vert->normal = (ObjCppNormal*)vert->normal;//(ObjCppNormal*)malloc(sizeof(ObjCppNormal));
                     obj_cpp_vert->texCoords = (ObjCppTexCoord*)vert->tex_cord
                     (ObjCppTexCoord*)malloc(sizeof(ObjCppTexCoord));*/
                }
            
            }
        }
    }
}

void copyModelInObjCppModel(Model *model,ObjCppModel *obj_cpp_model)
{
    
    size_t num_objs = model->getObjectListSize();
    //allocating object list in obj_cpp_model
    [obj_cpp_model setObjectListSize:num_objs];
    
    //copying all the objects in obj_cpp_model
    for (int i=0; i<num_objs; i++)
    {
        Object *source_obj = model->getObject(i);
        ObjCppObject *target_obj = [[ObjCppObject alloc] init];
        const char* obj_name = source_obj->getObjectName();
        NSString* name = @(obj_name);
        [target_obj setObjectName:name];
        copyObjectInObjCppObject(source_obj,target_obj);
        [obj_cpp_model addObjectAt:target_obj : i];
        //printf("target_obj is added to obj_cpp_model");
        
    }
    size_t num_child_models  = model->getChildModelListSize();
    //allocating child model list in obj_cpp_model
    [obj_cpp_model setChildModelListSize:num_child_models];
    for (int i=0; i<num_child_models; i++)
    {
        ObjCppModel *child = [[ObjCppModel alloc] init];
        copyModelInObjCppModel(model->getChild(i),child);
        [obj_cpp_model addChildModelAt:child : i];
    }
}

@implementation ObjCppModelLoader
-(ObjCppModel*) load:(NSString*)path
{
    std::string file_path = std::string([path UTF8String]);
    Model *model = ModelLoader::load(file_path);
    const char* model_name = model->getModelName();
    ObjCppModel *obj_cpp_model = [[ObjCppModel alloc] init];
    [obj_cpp_model setModelName:@(model_name)];
    copyModelInObjCppModel(model,obj_cpp_model);
    delete model;
    return obj_cpp_model;
}
-(void) dealloc
{
    
}
@end
