//
//  Pool.swift
//  LeleGroup
//
//  Created by Delvina Janice on 07/04/21.
//

import Foundation

struct Pool {
    var id: Int
    var name: String
    var alert: Alert
    
    static func generateDummyPool() -> [Pool]{
        return [
            Pool(id: 0, name: "Kolam 1",
                 alert: Alert(id: 0, temperature: 23.1, status: "normal", isActive: true, lastUpdate: Date()
                 )
            ),
            Pool(id: 0, name: "Kolam 2",
                 alert: Alert(id: 0, temperature: 27.1, status: "danger", isActive: false, lastUpdate: Date()
                 )
            ),
            Pool(id: 0, name: "Kolam 3",
                 alert: Alert(id: 0, temperature: 21.9, status: "warning", isActive: true, lastUpdate: Date()
                 )
            ),
            Pool(id: 0, name: "Kolam 4",
                 alert: Alert(id: 0, temperature: 23.1, status: "normal", isActive: true, lastUpdate: Date()
                 )
            ),
            Pool(id: 0, name: "Kolam 5",
                 alert: Alert(id: 0, temperature: 26.1, status: "danger", isActive: true, lastUpdate: Date()
                 )
            ),
        ]
       
    }
}
