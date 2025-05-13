//
//  Methods+ext.swift
//  InstagramFirebase
//
//  Created by User on 11.05.25.
//

import Foundation
import UIKit

extension UIViewController {
    func makeAlert(inputTitle:String ,inputMessage:String ){
        let alert  = UIAlertController(title: inputTitle, message: inputMessage, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
