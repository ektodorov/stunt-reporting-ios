//
//  ConstatnsStunt.swift
//  stunt-reporting-ios
//

import Foundation

class ConstantsStunt {
    
    static var kServiceUrl = "http://192.168.0.100:8080"
    static let kURL_Message = "/message"
    static let kURL_UploadFile = "/uploadfile"
    static let kURL_UploadImage = "/uploadimage"
    static let kURL_ClientInfo = "/sendclientinfo"

    static var sApiKey = "30ad1c571eec45e150cd4200f318a383"
    
    class func sendMessage(sequence: Int) {
        let timeSeconds: Int64 = Int64(Date().timeIntervalSince1970)
        let json: [String: Any] = ["apikey": ConstantsStunt.sApiKey,
            "sequence": sequence,
            "time": timeSeconds,
            "message": "iOS message 4",
            "clientid": "clientid_iOS"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        let endPoint: String = ConstantsStunt.kServiceUrl + ConstantsStunt.kURL_Message
        guard let url = URL(string: endPoint) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(ConstantsStunt.sApiKey, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
//        urlRequest.httpBody = "message from iOS 1".data(using: String.Encoding.utf8)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest, completionHandler: {(aData: Data?, aResponse: URLResponse?, aError: Error?)->Void in
            if aError != nil{
                print("onButtonSendString, Error=\(aError?.localizedDescription)")
                return
            }
            let strResponse = String(data: aData!, encoding: String.Encoding.utf8)
            print("onButtonSendString, response, strResponse=\(strResponse!)")
        })
        task.resume()
    }

    class func sendImage(sequence: Int, filePath: String) {
        let timeSeconds: Int64 = Int64(Date().timeIntervalSince1970)
        let json: [String: Any] = ["apikey": ConstantsStunt.sApiKey,
            "sequence": sequence,
            "time": timeSeconds,
            "message": "iOS message 2",
            "clientid": "clientid_iOS"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        let endPoint: String = ConstantsStunt.kServiceUrl + ConstantsStunt.kURL_UploadImage
        guard let url = URL(string: endPoint) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Keep-Alive", forHTTPHeaderField: "Connection")
        urlRequest.addValue("multipart/form-data", forHTTPHeaderField: "ENCTYPE")
        urlRequest.addValue("multipart/form-data;boundary=*************************7d41b838504d8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(ConstantsStunt.sApiKey, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "POST"
        
        var dataBody = Data()
        
        //write message part
        let boundary = "--*************************7d41b838504d8\r\n"
        var messageHeader = "Content-Disposition: form-data; name=\"message\"\r\n"
        let lineFeed = "\r\n"
        dataBody.append(boundary.data(using: String.Encoding.utf8)!)
        dataBody.append(messageHeader.data(using: String.Encoding.utf8)!)
        dataBody.append(lineFeed.data(using: String.Encoding.utf8)!)
        dataBody.append(jsonData!)
        dataBody.append(lineFeed.data(using: String.Encoding.utf8)!)
        
        //write file part
        messageHeader = "Content-Disposition: form-data; name=\"image\";filename=\"iosfilename\"\r\n"
        dataBody.append(boundary.data(using: String.Encoding.utf8)!)
        dataBody.append(messageHeader.data(using: String.Encoding.utf8)!)
        dataBody.append(lineFeed.data(using: String.Encoding.utf8)!)
        
        let fileHandle = FileHandle(forReadingAtPath: filePath)
        let fileData = fileHandle?.readDataToEndOfFile()
        fileHandle?.closeFile()
        dataBody.append(fileData!)
        
        dataBody.append(lineFeed.data(using: String.Encoding.utf8)!)
        let boundaryEnd = "--*************************7d41b838504d8--\r\n"
        dataBody.append(boundaryEnd.data(using: String.Encoding.utf8)!)
        
        urlRequest.httpBody = dataBody
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest)
        task.resume()
    }
    
    class func sendFile(sequence: Int, filePath: String) {
        let timeSeconds: Int64 = Int64(Date().timeIntervalSince1970)
        let json: [String: Any] = ["apikey": ConstantsStunt.sApiKey,
            "sequence": sequence,
            "time": timeSeconds,
            "message": "iOS message 2",
            "clientid": "clientid_iOS"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        let endPoint: String = ConstantsStunt.kServiceUrl + ConstantsStunt.kURL_UploadFile
        guard let url = URL(string: endPoint) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Keep-Alive", forHTTPHeaderField: "Connection")
        urlRequest.addValue("multipart/form-data", forHTTPHeaderField: "ENCTYPE")
        urlRequest.addValue("multipart/form-data;boundary=*************************7d41b838504d8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(ConstantsStunt.sApiKey, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "POST"
        
        var dataBody = Data()
        
        //write message part
        let boundary = "--*************************7d41b838504d8\r\n"
        var messageHeader = "Content-Disposition: form-data; name=\"message\"\r\n"
        let lineFeed = "\r\n"
        dataBody.append(boundary.data(using: String.Encoding.utf8)!)
        dataBody.append(messageHeader.data(using: String.Encoding.utf8)!)
        dataBody.append(lineFeed.data(using: String.Encoding.utf8)!)
        dataBody.append(jsonData!)
        dataBody.append(lineFeed.data(using: String.Encoding.utf8)!)
        
        //write file part
        messageHeader = "Content-Disposition: form-data; name=\"file\";filename=\"iosfilename\"\r\n"
        dataBody.append(boundary.data(using: String.Encoding.utf8)!)
        dataBody.append(messageHeader.data(using: String.Encoding.utf8)!)
        dataBody.append(lineFeed.data(using: String.Encoding.utf8)!)
        
        let fileHandle = FileHandle(forReadingAtPath: filePath)
        let fileData = fileHandle?.readDataToEndOfFile()
        fileHandle?.closeFile()
        dataBody.append(fileData!)
        
        dataBody.append(lineFeed.data(using: String.Encoding.utf8)!)
        let boundaryEnd = "--*************************7d41b838504d8--\r\n"
        dataBody.append(boundaryEnd.data(using: String.Encoding.utf8)!)
        
        urlRequest.httpBody = dataBody
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest)
        task.resume()
    }
    
    class func sendClientInfo(sequence: Int) {
        let json: [String: Any] = ["apikey": ConstantsStunt.sApiKey,
            "clientid": "clientid_iOS",
            "name": "iosclient",
            "manufacturer": "apple",
            "model": "iosdevice",
            "deviceid": "iosdeviceid",
            "sequence": sequence]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        let endPoint: String = ConstantsStunt.kServiceUrl + ConstantsStunt.kURL_ClientInfo
        guard let url = URL(string: endPoint) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(ConstantsStunt.sApiKey, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest, completionHandler: {(aData: Data?, aResponse: URLResponse?, aError: Error?)->Void in
            if aError != nil{
                print("onButtonSendString, Error=\(aError?.localizedDescription)")
                return
            }
            let strResponse = String(data: aData!, encoding: String.Encoding.utf8)
            print("onButtonSendString, response, strResponse=\(strResponse!)")
        })
        task.resume()
    }
}
