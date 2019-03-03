//
//  ViewController.swift
//  GoogleSpreadSheetApp
//
//  Created by REO HARADA on 2019/03/03.
//  Copyright © 2019年 reo harada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gasURLTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func tapExampleButton(_ sender: Any) {
        let example = "https://script.google.com/macros/s/AKfycbyhcFLkmJdtxWftOz82PMsmR8y7L9Ls-Iyex7kJ12lzHl0Ifwnz/exec"
        let defaults = UserDefaults.standard
        defaults.set(example, forKey: "GASEntryURL")
        defaults.synchronize()
        if let next = storyboard?.instantiateViewController(withIdentifier: "GASViewController") {
            next.modalTransitionStyle = .partialCurl
            present(next, animated: true, completion: nil)
        }
    }
    

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlStr = gasURLTextField.text
        let defaults = UserDefaults.standard
        defaults.set(urlStr, forKey: "GASEntryURL")
        defaults.synchronize()
        print(urlStr)
        if let next = storyboard?.instantiateViewController(withIdentifier: "GASViewController") {
            next.modalTransitionStyle = .partialCurl
            present(next, animated: true, completion: nil)
        }
        return true
    }
}
