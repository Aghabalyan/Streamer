//
//  SegmentsService.swift
//  Streamer
//
//  Created by Varmtech on 2/5/19.
//  Copyright © 2019 Varmtech. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper
import Alamofire

class SegmetService {
    
    static let shered = SegmetService()
    
    func segmentsResponse(data: SegmentsForm, completion: @escaping ((SegmentsResponseData<SegmentsResponse>) -> Void)) {
        BaseService.shared.get(endpoint: "/templates", parameters: data.toJSON(), for: .unsecure)
            .responseString { (response) in
                print(response.result.value ?? nil)
                if let responseHttp = response.response, let value = response.result.value {
                    if let baseResponse = BaseService.shared.checkBaseResponse(responseHttp, value) {
                        return completion(.base(response: baseResponse))
                    }
                } else {
                    return completion(.isOffline)
                }
                
                switch response.response?.statusCode ?? 400 {
                case 200:
                    if let value = response.result.value, let data = Mapper<SegmentsResponse>().mapArray(JSONString: value) {
                        return completion(.success(segmets: data))
                    }
                    return completion(.base(response: .unexpectedError(error: ResponseUnexpectedError.mappingFailed)))
                default:
                    return completion(.base(response: .badRequest))
                }
        }
    }
}
