//
//  PressButtonProtocols.swift
//  mySchedule
//
//  Created by Grigore on 03.04.2023.
//

import Foundation

protocol PressDoneTaskButtonProtocol: AnyObject {
    func doneButtonTapped(indexPath: IndexPath)
    
}

protocol SwitchRepeatProtocol: AnyObject {
    func SwitchRepeat(value: Bool)
    
}
