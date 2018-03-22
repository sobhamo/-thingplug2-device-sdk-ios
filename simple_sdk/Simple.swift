//
//  Simple.swift
//  simple_sdk
//
//  Created by JONGILKIM on 2017. 11. 23..
//  Copyright © 2017년 JONGILKIM. All rights reserved.
//

import Foundation

public class Simple {
    
    var mqttClient: MQTTClient?
    var content: String = ""
    var dataArry:[NSMutableDictionary] = []
    
    /**
     * @brief init
     * @param[in] mqttClinet : MQTT client
     */
    public init(mqttClient: MQTTClient) {
        self.mqttClient = mqttClient
    }
    public func tpSimpleTelemetry(_ elements: NSMutableDictionary) -> UInt16{
        var returnValue: UInt16 = 0
        
        if dataArry.count > 0{
            dataArry.append(elements)
            if let mqttClient = self.mqttClient {
                returnValue = mqttClient.publishMessage(message: dataArry, operationType: .OPERATION_TELEMETRY)
                dataArry.removeAll()
            }
            return returnValue
        } else {
            if let mqttClient = self.mqttClient {
                returnValue = mqttClient.publishMessage(message: elements, operationType: .OPERATION_TELEMETRY)
            }
            return returnValue
        }
    }
    
    public func tpSimpleAttribute(_ elements: NSMutableDictionary) -> UInt16{
        var returnValue: UInt16 = 0
        if let mqttClient = self.mqttClient {
            returnValue = mqttClient.publishMessage(message: elements, operationType: .OPERATION_ATTRIBUTE)
        }
        return returnValue
    }
    
    public func tpSimpleResult(_ rpcResponse: RPCResponse) -> UInt16{
        var returnValue: UInt16 = 0
        
        if let mqttClient = self.mqttClient {
            returnValue = mqttClient.publishMessage(message: self.makeJsonforResult(rpcResponse), messageType: .TYPE_JSONSTRING, operationType: .OPERATION_RESULT)
        }
        
        return returnValue
    }
    
    public func tpSimpleSubscribe(_ elements: NSMutableDictionary) -> UInt16{
        var returnValue: UInt16 = 0
        
        if let mqttClient = self.mqttClient {
            returnValue = mqttClient.publishMessage(message: elements, operationType: .OPERATION_SUBSCRIBE)
        }
        return returnValue
    }
    
    
    public func tpSimpleRawTelemetry(_ elements: NSString , messageType:MessageType) -> UInt16{
        var returnValue: UInt16 = 0
        
        if let mqttClient = self.mqttClient {
            returnValue = mqttClient.publishMessage(message: elements, messageType: messageType, operationType: .OPERATION_TELEMETRY)
        }
        return returnValue
    }
    
    public func tpSimpleRawAttribute(_ elements: NSString, messageType:MessageType) -> UInt16{
        var returnValue: UInt16 = 0
        if let mqttClient = self.mqttClient {
            returnValue = mqttClient.publishMessage(message: elements, messageType: messageType, operationType: .OPERATION_ATTRIBUTE)
        }
        return returnValue
    }
    
    public func tpSimpleRawResult(_ elements: NSString) -> UInt16{
        var returnValue: UInt16 = 0
        
        if let mqttClient = self.mqttClient {
            returnValue = mqttClient.publishMessage(message: elements, messageType: .TYPE_JSONSTRING, operationType: .OPERATION_RESULT)
        }
        
        return returnValue
    }
    
    public func tpSimpleAddData(_ elements: NSMutableDictionary){
        dataArry.append(elements)
    }
    
    private func makeJsonforResult(_ rpcResponse: RPCResponse) -> NSString{
        //let jSonString: NSString = ""
        
        var resultDictionary: [String: AnyObject] = NSMutableDictionary() as! [String : AnyObject]
        var rpcRspDictionary: [String: AnyObject] = NSMutableDictionary() as! [String : AnyObject]
        var rpcResultDictionary: [String: AnyObject] = NSMutableDictionary() as! [String : AnyObject]
        
        rpcResultDictionary.updateValue(rpcResponse.resultDic as AnyObject, forKey: Define.RPC_RSP)
        
        rpcRspDictionary.updateValue(rpcResponse.jsonrpc as AnyObject, forKey: Define.JSONRPC)
        rpcRspDictionary.updateValue(rpcResponse.id as AnyObject, forKey: Define.ID)
        
        resultDictionary.updateValue(rpcResponse.result as AnyObject, forKey: Define.RESULT)
        resultDictionary.updateValue(rpcResponse.cmd as AnyObject, forKey: Define.CMD)
        resultDictionary.updateValue(rpcResponse.cmdId as AnyObject, forKey: Define.CMD_ID)
        resultDictionary.updateValue(rpcRspDictionary as AnyObject, forKey: Define.RPC_RSP)

        if let jsonData = try? JSONSerialization.data(withJSONObject: resultDictionary, options: .prettyPrinted),
            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8){
            
            
            _console("makeJsonforResult return = \n\(jsonString)")
            return jsonString as NSString
        }
        _console("makeJsonforResult return = fail)")
        return ""
    }
    
    public func tpSimpleJsonRpcReq(controlParams:NSMutableArray, cmdId:NSInteger, isTwoWay:Bool)-> UInt16{
        var returnValue: UInt16 = 0
        let subscribeDictionary:NSMutableDictionary = [:]
        let rpcReqDictionary:NSMutableDictionary = [:]

        rpcReqDictionary.addEntries(from: ["jsonrpc" : "2.0"])
        rpcReqDictionary.addEntries(from: ["id" : cmdId])
        rpcReqDictionary.addEntries(from: ["method" : "tp_user"])
        rpcReqDictionary.addEntries(from: ["params" : controlParams])
        
        subscribeDictionary.addEntries(from: ["cmdId" : cmdId])
        subscribeDictionary.addEntries(from: ["cmd" : "jsonRpc"])
        subscribeDictionary.addEntries(from: ["serviceName" : self.mqttClient?.host?.serviceName ?? ""])
        subscribeDictionary.addEntries(from: ["deviceName" : self.mqttClient?.host?.deviceName ?? ""])
        subscribeDictionary.addEntries(from: ["rpcReq" : rpcReqDictionary])
        if(isTwoWay){
            subscribeDictionary.addEntries(from: ["rpcMode" : "twoway"])
        } else {
            subscribeDictionary.addEntries(from: ["rpcMode" : "oneway"])
        }
        
        if self.mqttClient != nil {
            returnValue = self.tpSimpleSubscribe(subscribeDictionary)
        }
        return returnValue
    }
    
    public func tpSimpleSetAttribute(controlParams:NSMutableDictionary, cmdId:NSInteger)-> UInt16{
        var returnValue: UInt16 = 0
        let ReqDictionary:NSMutableDictionary = [:]
        
        ReqDictionary.addEntries(from: ["serviceName" : self.mqttClient?.host?.serviceName ?? ""])
        ReqDictionary.addEntries(from: ["deviceName" : self.mqttClient?.host?.deviceName ?? ""])
        ReqDictionary.addEntries(from: ["cmdId" : cmdId])
        ReqDictionary.addEntries(from: ["cmd" : "setAttribute"])
        ReqDictionary.addEntries(from: ["attribute" : controlParams])

        
        if self.mqttClient != nil {
            returnValue = self.tpSimpleSubscribe(ReqDictionary)
        }
        return returnValue
    }
}
