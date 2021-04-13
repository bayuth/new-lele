//
//  Alert.swift
//  LeleGroup
//
//  Created by Delvina Janice on 07/04/21.
//

import Foundation

struct Alert {
    var id: Int
    var temperature: Double
    var status: String
    var isActive: Bool
    var lastUpdate: Date
    
    static func generateDummyAlert() -> [Pool]{
        return [
            Pool(id: 0, name: "Kolam 1",
                 alert: Alert(id: 0, temperature: 25.1, status: "danger", isActive: true, lastUpdate: Date()
                 )
            ),
            Pool(id: 0, name: "Kolam 2",
                 alert: Alert(id: 0, temperature: 27.1, status: "danger", isActive: true, lastUpdate: Date()
                 )
            ),
            Pool(id: 0, name: "Kolam 2",
                 alert: Alert(id: 0, temperature: 22.9, status: "warning", isActive: true, lastUpdate: Date()
                 )
            ),
            Pool(id: 0, name: "Kolam 3",
                 alert: Alert(id: 0, temperature: 25.1, status: "danger", isActive: true, lastUpdate: Date()
                 )
            ),
            Pool(id: 0, name: "Kolam 3",
                 alert: Alert(id: 0, temperature: 25.4, status: "danger", isActive: true, lastUpdate: Date()
                 )
            ),
        ]
       
    }
}
