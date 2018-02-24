//
//  CppToC.h
//  MetalRenderingEngine
//
//  Created by Gaurav Sharma on 19/02/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

#ifndef CppToC_h
#define CppToC_h
#include "Object.hpp"
#include "Headers/Model.hpp"
#include "Headers/DataType.hpp"
#include "Headers/ModelLoader.hpp"
Object* getObject(int i);
Model* load(std::string &path);

#endif /* CppToC_h */
