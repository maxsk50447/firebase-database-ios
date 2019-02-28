//
//  ViewController.swift
//  DemoDatabase
//
//  Created by Patipol Wangjaitham on 7/2/2562 BE.
//  Copyright © 2562 Patipol Wangjaitham. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref:DatabaseReference!
    
    var postData = ["Item 1", "Item 2", "Item 3"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        ref.child("Posts").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            if let valueDictionary = snapshot.value as? [AnyHashable:String] {
                let title = valueDictionary["title"]
                self.postData.insert(title ?? "", at: 0)
                
                self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        
        cell?.textLabel?.text = postData[indexPath.row]
        
        return cell!
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
