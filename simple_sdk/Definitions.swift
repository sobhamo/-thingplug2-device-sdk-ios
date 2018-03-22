//
//  Definitions.swift
//  simple_sdk
//
//  Created by JONGILKIM on 2017. 11. 23..
//  Copyright © 2017년 JONGILKIM. All rights reserved.
//

/**
 * MQTTClient Conn Ack
 */
public enum MQTTConnAck: UInt8 {
    case accept = 0
    case unacceptableProtocolVersion
    case identifierRejected
    case serverUnavailable
    case badUsernameOrPassword
    case notAuthorized
    case reserved
}

/**
 * MQTTClient Conn Status
 */

public enum MQTTConnectionStatus {
    case DISCONNECTED
    case CONNECTING
    case CONNECTED
}

public enum OperationType: UInt8 {
    case OPERATION_ATTRIBUTE = 1
    case OPERATION_TELEMETRY
    case OPERATION_RESULT
    case OPERATION_SUBSCRIBE
}


public enum MessageType: UInt8 {
    case TYPE_NONE = 1
    case TYPE_JSONSTRING
    case TYPE_CSV
    case TYPE_OFFSET
}


public struct Define {
    /** command(string) **/
    static let CMD = "cmd";
    /** command ID(int) **/
    static let CMD_ID = "cmdId";
    /** device ID(string) **/
    static let DEVICE_ID = "deviceId";
    /** telemetry(string array) **/
    static let TELEMETRY = "telemetry";
    /** attribute(string array) **/
    static let ATTRIBUTE = "attribute";
    /** attribute(string array) **/
    static let UP = "up";
    static let TOPIC_CSV = "csv";
    static let TOPIC_OFFSET = "offset";
    /** RPC response(JSON) **/
    static let RPC_RSP = "rpcRsp";
    /** JSON RPC version(string) **/
    static let JSONRPC = "jsonrpc";
    /** Identifier(int) **/
    static let ID = "id";
    /** method(string) **/
    static let METHOD = "method";
    /** control result **/
    static let RESULT = "result";
    /** error(JSON) **/
    static let ERROR = "error";
    /** error code(int) **/
    static let CODE = "code";
    /** error message(string) **/
    static let MESSAGE = "message";
    /** result status(string) **/
    static let STATUS = "status";
    /** result success(string) **/
    static let SUCCESS = "success";
    /** result fail(string) **/
    static let FAIL = "fail";
    /** SDK version **/
    static let VERSION = "1.0";
    /** device name(string) **/
    static let DEVICE_NAME = "deviceName";
    /** service name(string) **/
    static let SERVICE_NAME = "serviceName";
    /** sensor node ID(string) **/
    static let SENSOR_NODE_ID = "sensorNodeId";
    /** is target all(boolean) **/
    static let IS_TARGET_ALL = "isTargetAll";
    
    /** Error code **/
    static let INTERNAL_SDK_ERROR = 9999;
}
/**
 * String Ack
 */

func _console(_ info: String) {
    print("TP_SIMPLE_SDK : \(info)")
}
