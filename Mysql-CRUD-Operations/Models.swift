//
//  Models.swift
//  Mysql-CRUD-Operations
//
//  Created by March Tala on 3/19/22.
//

import Foundation
import SwiftUI

struct DataModel: Decodable {
//    let error: Bool;
    let Status: Int;
    let Projects: [ProjectModel];
}

struct ProjectModel: Decodable {
    let Id: Int
    let Name: String
    let Description: String
}
