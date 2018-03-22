//
//  Host.swift
//  simple_sdk
//
//  Created by JONGILKIM on 2017. 11. 23..
//  Copyright © 2017년 JONGILKIM. All rights reserved.
//

public class Host {
    
    //MARK: Properties
    public var serviceName: String
    public var deviceName: String
    var deviceToken: String
    public var host: String
    public var port: String
    public var clientId: String?
    public var userName: String?
    public var password: String?
    public var usingSSL: Bool
    public var cleanSession: Bool
    var status: MQTTConnectionStatus
    
    //MARK: Initialization
    public init(serviceName:String, deviceName:String, deviceToken: String, host: String, port: String, clientId: String?, userName: String?, password: String?, usingSSL: Bool, cleanSession: Bool) {
        self.serviceName = serviceName
        self.deviceName = deviceName
        self.deviceToken = deviceToken
        self.host = host
        self.port = port
        self.clientId = clientId
        self.userName = userName
        self.password = password
        self.usingSSL = usingSSL
        self.cleanSession = cleanSession
        self.status = MQTTConnectionStatus.DISCONNECTED
        _console("HOST serviceName: \(self.serviceName)")
        _console("HOST deviceName: \(self.deviceName)")
        _console("HOST name: \(self.deviceToken)")
        _console("HOST host: \(self.host)")
        _console("HOST port: \(self.port)")
        _console("HOST clientId: \(String(describing: self.clientId))")
        _console("HOST password: \(String(describing: self.password))")
        _console("HOST usingSSL: \(self.usingSSL)")
        _console("HOST cleanSession: \(self.cleanSession)")
        _console("HOST status: \(self.status)")
    }
}

