//
//  UserStruct.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 26/05/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User : Hashable, Codable {
    @DocumentID var id: String?
    var name: String
    var surname: String
    var useButtons : Bool = false
    var usePoseEstimation : Bool = false
    var useVoiceOver : Bool = false
    var rows : Int = 3
    var columns : Int = 3
}
