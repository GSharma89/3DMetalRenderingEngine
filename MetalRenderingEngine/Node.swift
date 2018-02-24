


import Foundation
import MetalKit
class Node
{
    var name:String!
    var transform:Transform!
    var meshGenerator:ObjectMeshGenerator!
    var textureLoader:TextureLoader!
    var device:MTLDevice!
    var type:NodeType!
    var parent:Node!
    var messData:([Vertex],[UInt32])?
    var childNodes = [Node]()
    var textureImage:String!
    init(id:String,device:MTLDevice,nodeType:NodeType,meshGenerator:ObjectMeshGenerator,textureLoader:TextureLoader,parentNode:Node?,imageName:String?)
    {
        name = id
        type = nodeType
        parent = parentNode
        self.device = device
        transform = Transform()
        self.meshGenerator = meshGenerator
        self.textureLoader = textureLoader
        textureImage = imageName
        messData = nil
        
    }
    
    func update(frameNo:Int32)
    {
        
       
        switch type! {
        
        
        case .GRE_PLANET:
            
            let planet = self as! Planet
            
            if(planet.animate)
            {
                
                /*Here we have taken revolution rate and rotation rate differently with respect of number of frames.
                
                Planet spinning days to frames mapping for rotation of planet about their own axe
                ---------------------------------------------------------------------------------
                1.I have taken 360 frames per earth day for rotation.it means that 360 frames are equal to 1 day and if
                any planet takes n days to be rotated 360 degree around its own axe then in this application, planet will
                complete its 360 degree rotation in n*360 frames.
                
                Planet revolution days to frames mapping for revolution of planet about sun
                ---------------------------------------------------------------------------
                
                2.I have taken 1 frame per earth day for revolution.it means that if any planet takes n days to complete its on revolution around sun then in this application,it will take 1*n frames to complete one revolution around sun.
                */
                
                let revolve_period = planet.no_of_days_to_be_revolved
                
                let framesPerRevolution = Int32(1 * planet.no_of_days_to_be_revolved)
                
                let revolve_angle = (360.0/Float(1 * revolve_period)) * Float((frameNo % framesPerRevolution))
                
                let rotate_period = planet.rotate_period
                
                let framesPerRotation = Int32(360 * planet.rotate_period)
                
                let rotate_angle = (360.0/Float(360 * rotate_period)) * Float((frameNo % framesPerRotation))
                transform.model_matrix = matrix_identity_float4x4
                transform.model_matrix = matrix_multiply(getScaleMatrix(transform.scale.x, y: transform.scale.y, z: transform.scale.z), transform.model_matrix)
                transform.model_matrix = matrix_multiply(getRotationAroundY(Float(Double.pi) * (rotate_angle/180)), transform.model_matrix)
                transform.model_matrix = matrix_multiply(getTranslationMatrix(transform.position), transform.model_matrix)
                transform.model_matrix = matrix_multiply(getRotationAroundY(Float(Double.pi) * (revolve_angle/180)), transform.model_matrix)
                

            }
            break
            
            
            
        case .GRE_CUBE:
            
            transform.rotation = vector_float3(Float(Double(frameNo)*0.05))
            transform.model_matrix = matrix_identity_float4x4
            /*transform.model_matrix = matrix_multiply(getRotationAroundX(transform.rotation.x), transform.model_matrix)
            transform.model_matrix = matrix_multiply(getRotationAroundY(transform.rotation.y), transform.model_matrix)
            transform.model_matrix = matrix_multiply(getRotationAroundZ(transform.rotation.z), transform.model_matrix)*/
            //transform.model_matrix = matrix_multiply(getTranslationMatrix(transform.position+vector_float4(Float(Double(frameNo)*0.05),0,0,0)), transform.model_matrix)
           
            
            break
            
        case .GRE_RECT:
            
            print("Animation is not supported on Rect")
            
            break
        
        default:
            //print("Type is mismatched")
            
            break
            }
        
        for child in childNodes
        {
            child.update(frameNo: frameNo)
        }
    }
    
    func addPlanetNode(id:String,textureImage:String,device:MTLDevice)->Node?
    {
        var planet:Planet! = nil
        if(type == NodeType.GRE_GROUP )
        {
            planet = Planet.init(name: id,  textureImage: textureImage, type: .GRE_PLANET, device:self.device,
                                 meshGenerator:meshGenerator,textureLoader:textureLoader,parent:self)
            childNodes.append(planet)
        }
        return planet
    }
    
    func addCubeNode(id: String, device: MTLDevice,imageName:String)->Node?
    {
        var cube:Cube! = nil
        if(type == NodeType.GRE_GROUP)
        {
            cube = Cube.init(nodeName: id, device: device, nodeType: .GRE_CUBE , textureImage: imageName, meshGenerator: meshGenerator, textureLoader: textureLoader, parent: self)
            childNodes.append(cube)
        }
        return cube
    }
    
    func addRectNode(id: String, device: MTLDevice, nodeType: NodeType,textureImage:String)->Node?
    {
        var rect:Rect!
        if(type == NodeType.GRE_RECT)
        {
        
        rect = Rect.init(nodeName: id, device: device, nodeType: .GRE_RECT, textureImage: textureImage, meshGenerator: meshGenerator, textureLoader: textureLoader, parent: self)
            childNodes.append(rect)
        }
        return rect
    }
    func getLeafNodeCount()->Int
    {
        var count = 0
        if(type != NodeType.GRE_GROUP)
        {
            count += 1
        }
        else
        {
            for child in childNodes
            {
                count = count + child.getLeafNodeCount()
            }
        }
        return count
    }
    
    /*this is recursive method which will add ObjCppModel as node in node tree and type of node will be GRE_MESS because
     model already has mess data so we need not to use object mesh generator*/
    func addObjCppModel(model:ObjCppModel)
    {
        let object_list_size:Int  = (model.getObjectListSize())
        
        for i in 0..<object_list_size
        {
            let obj = model.getObject(Int32(i));
            
            let obj_name = (obj?.getName())!
            let mess_node = Node.init(id:obj_name , device: device, nodeType: .GRE_MESS, meshGenerator: meshGenerator, textureLoader: textureLoader, parentNode: self, imageName: textureImage)
            
            var vertices = [Vertex]()
            var indices =  [UInt32]()
            let vert_list_size:Int = (obj?.getVertexListSize())!
            
            for j in 0..<vert_list_size
            {
                let vert = (obj?.getVertexAt(Int32(j)))?.pointee;
                let pos = Vector4.init(x: (vert?.position.pointee.x)!, y: (vert?.position.pointee.y)!, z: (vert?.position.pointee.z)!, w: (vert?.position.pointee.w)!)
                //print("pos:\(pos.x) \(pos.y) \(pos.z) \(pos.w)")
                
                let normal = Vector4.init(x: (vert?.normal.pointee.x)!, y: (vert?.normal.pointee.y)!, z: (vert?.normal.pointee.z)!, w: (vert?.normal.pointee.w)!)
                //print("normal:\(normal.x) \(normal.y) \(normal.z) \(normal.w)")
                let tex_cord = Vector4.init(x:(vert?.texCoords.pointee.u)! , y:(vert?.texCoords.pointee.v)!,z:(vert?.texCoords.pointee.w)!,w:(vert?.texCoords.pointee.t)!)
                
                //print("tex_cord:\(tex_cord.x) \(tex_cord.y) \(tex_cord.z)")
                let vertex = Vertex(position:pos , normal: normal, texCoords: tex_cord);
                vertices.append(vertex)
                indices.append(UInt32(j))
            }
            mess_node.messData = (vertices,indices)
            childNodes.append(mess_node)
        }
        
        //now repeate above copying process for all child models of ObjCppModel
        
        let child_model_list_size = model.getChildModelListSize();
        
        for i in 0..<child_model_list_size
        {
            let child_model = model.getChildModel(Int32(i))
            let child_group_node = Node.init(id: (child_model?.getName())!, device: device, nodeType: .GRE_GROUP, meshGenerator: meshGenerator, textureLoader: textureLoader, parentNode: self, imageName: textureImage)
            childNodes.append(child_group_node)
            child_group_node.addObjCppModel(model: child_model!)
        }
        
    }
        
    func updateNodesMess(nodeMessList:[NodeType:NodeMess])
    {
        
        if(type != .GRE_GROUP)
        {
            let mess = nodeMessList[type]
            var messData:([Vertex],[UInt32])? = nil
            switch type!
            {
                case .GRE_PLANET:
                
                    if(mess?.verticesBuffer == nil)
                    {
                        messData = meshGenerator.getSphereVerticesMesh(center: float3(0,0,0), radius: 1, slices: 1000, slice_triangles: 400)
                        
                    }
                   break
        
            case .GRE_CUBE:
                    if(mess?.verticesBuffer == nil)
                    {
                        messData = meshGenerator.getQubeMess(side: 1)
                    }
                
                break
            case .GRE_RECT:
                    if(mess?.verticesBuffer == nil)
                    {
                        messData = meshGenerator.getRectangleMess(x: 0, y: 0, width: 1, height: 1)
                    }
                    break
        
             
            case .GRE_MESS:
                        if(mess?.verticesBuffer == nil)
                        {
                            messData = self.messData
                        }
            default:
                    print("No node matched")
            
                    break
        
        
        }
        
        if(mess?.verticesBuffer == nil)
        {
            mess?.verticesBuffer = device.makeBuffer(bytes: (messData?.0)!, length: MemoryLayout<Vertex>.stride * (messData?.0.count)!, options: .storageModeShared)
            mess?.indicesBuffer = device.makeBuffer(bytes: (messData?.1)!, length: MemoryLayout<UInt32>.size * (messData?.1.count)!, options: .storageModeShared)
            mess?.index_count = (messData?.1.count)!
        }
        mess?.instance_count = (mess?.instance_count)! + 1
        
       
        mess?.nodeTransformArray.append(transform.model_matrix)
        
            if textureImage != nil { mess?.textureImagesArray.append(textureImage)}
        
    
        }
        for child in childNodes
        {
            child.updateNodesMess(nodeMessList: nodeMessList)
        }
    }
    
}

