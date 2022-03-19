//
//  Mysql_CRUD_OperationsApp.swift
//  Mysql-CRUD-Operations
//
//  Created by March Tala on 3/19/22.
//

import SwiftUI

@main
struct Mysql_CRUD_OperationsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ViewModel())
        }
    }
}
