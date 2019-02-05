//
//  Segments.swift
//  Streamer
//
//  Created by Varmtech on 2/5/19.
//  Copyright © 2019 Varmtech. All rights reserved.
//

import ObjectMapper
import UIKit

class SegmentsForm: Mappable {
    
    var f: String?
    
    init(f: String) {
        self.f = f
    }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        f <- map["f"]
    }
}

class SegmentsResponse: Mappable {
    
    var title: String?
    var segments: [Segment]?
  
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        title <- map["Title"]
        segments <- map["Segments"]
    }
}

class Segment: Mappable {
    
    var title: String?
    var url: String?
    var steps: [Steps]?
    
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        title <- map["Title"]
        url <- map["URL"]
        steps <- map["Steps"]
    }
}

class Steps: Mappable {
    
    var stage: String?
    var stageIcon: String?
    var interval: Int?
    var name: String?
    var rise: String?
    
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        stage <- map["stage"]
        stageIcon <- map["stage_icon"]
        interval <- map["interval"]
        name <- map["name"]
        rise <- map["rise"]
    }
}

enum SegmentsResponseData<SegmentsResponse> {
    case success(segmets: [SegmentsResponse])
    case base(response: BaseResponse)
    case isOffline
}
