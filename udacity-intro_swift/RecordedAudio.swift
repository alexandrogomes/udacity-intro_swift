//
//  RecordedAudio.swift
//  udacity-intro_swift
//
//  Created by Alexandro on 8/20/15.
//  Copyright (c) 2015 Alexandro. All rights reserved.
//

import Foundation


class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(title:String,filePathUrl: NSURL) {
        self.title = title
        self.filePathUrl = filePathUrl
        super.init()
    }
}