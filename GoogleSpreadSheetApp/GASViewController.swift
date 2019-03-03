//
//  GASViewController.swift
//  GoogleSpreadSheetApp
//
//  Created by REO HARADA on 2019/03/03.
//  Copyright © 2019年 reo harada. All rights reserved.
//

import UIKit

class GASViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listTableView: UITableView!
    var listData: [[Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        guard let GASEntryURL = defaults.object(forKey: "GASEntryURL") as? String else { return }
        guard let url = URL(string: GASEntryURL) else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        guard let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[Any]] else { return }
        if let ld = jsonObj {
            listData = ld
        }
        listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var initPos = CGPoint(x: 0, y: 0)
        listData[indexPath.row].forEach { (val) in
            let text = convertText(val)
            let button = UIButton(frame: CGRect(x: initPos.x, y: initPos.y, width: cell.frame.size.width, height: 44))
            button.setTitle(text, for: .normal)
            button.setTitleColor(UIColor.blue, for: .normal)
            button.addTarget(self, action: #selector(GASViewController.telephone(_:)), for: .touchDown)
            cell.addSubview(button)
            initPos.y += 44
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(listData[indexPath.row].count * 44 + 16)
    }
    
    @objc func telephone(_ button: UIButton) {
        let title = button.title(for: .normal)
        if let replacedT = title?.replacingOccurrences(of: "-", with: "") {
            let telProtcol = "tel:\(replacedT)"
            guard let telURL = URL(string: telProtcol) else { return }
            UIApplication.shared.open(telURL, options: [:], completionHandler: nil)
        }
    }
    
    fileprivate func convertText(_ any: Any) -> String {
        if let str = any as? String { return str }
        if let num = any as? Int { return String(num) }
        return ""
    }
    
    fileprivate func joinWordToArray(_ array: [Any]) -> String {
        var res = ""
        array.forEach { (val) in
            if let str = val as? String {
                res.append("\(str)\n")
            }
            if let num = val as? Int {
                res.append("\(num)\n")
            }
        }
        return res
    }
}
