//
//  AppParser.swift
//  WinchCore
//
//  Created by Salah Amassi on 10/15/20.
//  Copyright © 2020 winch. All rights reserved.
//

import Foundation
import SwiftyJSON

class BalbildParser {
    
    enum ParserResult<T: SwiftyModelData> {
        case data(_ data: BaseModel<T>)
        case failure(_ error: String)
    }
    
    static func parse<T: SwiftyModelData>(data: Data, _ type: T.Type) -> ParserResult<T> {
        handleBaseModel(data: data)
    }
    
    private static func handleBaseModel<T: SwiftyModelData>(data: Data)-> ParserResult<T>{
        let baseModel = BaseModel<T>(json: JSON(data))
        if let error = getError(baseModel.message){
            return ParserResult.failure(error)
        }else{
            return ParserResult.data(baseModel)
        }
    }
    
    private static func getError(_ message: String)-> String?{
        message.isEmpty ? nil : message
    }
}
