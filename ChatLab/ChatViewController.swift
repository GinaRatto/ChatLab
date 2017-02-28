//
//  ChatViewController.swift
//  ChatLab
//
//  Created by Gina Ratto on 2/23/17.
//  Copyright © 2017 Gina Ratto. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.getMessages), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMessages() {
        let query = PFQuery(className: "Message")
        query.includeKey("username")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                
                if let objects = objects {
                    self.messages = objects
                    self.tableView.reloadData()
                }
            }
            else {
            }
        }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let message = PFObject(className: "Message")
        message["text"] = messageTextField.text
        message["username"] = PFUser.current()?.username
        message.saveInBackground { (success: Bool, error: Error?) in
            if(success) {
            }
            else {
            }
        }
        self.messageTextField.text = ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        let message = self.messages[indexPath.row]
        
        if(message["username"] != nil) {
            cell.usernameLabel.text = message["username"] as? String
        }
        else {
            cell.usernameLabel.isHidden = true
        }
        
        cell.messageLabel.text = message["text"] as? String
        return cell
        
    }
}
