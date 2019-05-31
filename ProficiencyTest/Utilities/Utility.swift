//
//  Utility.swift
//  ProficiencyTest
//
//  Created by mac_admin on 29/05/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import SystemConfiguration
import UIKit

class Utility {
    static func isConnectedToInternet() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
    
    static func showAlert(title: String, message: String, buttonLabel: String, currentVC: UIViewController?) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertDismissAction = UIAlertAction(title: buttonLabel, style: .default, handler: nil)
        alertView.addAction(alertDismissAction)
        currentVC?.present(alertView, animated: true, completion: nil )
        
    }
}
