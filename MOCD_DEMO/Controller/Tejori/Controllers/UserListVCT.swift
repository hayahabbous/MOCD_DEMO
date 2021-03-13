//
//  UserListVC.swift
//  Edkhar
//
//  Created by indianic on 27/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class UserListVCT: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tblUserlist: UITableView!
    var mutArrUserInfoList = [userInfoModelT]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tblUserlist.tableFooterView = UIView()
        FetchUserList()
    }
    
    func FetchUserList() -> Void {
        
        if self.mutArrUserInfoList.count > 0 {
            self.mutArrUserInfoList.removeAll()
        }
        
        // Fetch all records from model classs via database.
        self.mutArrUserInfoList = userInfoManagerT().GetAllUserInfoList()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tblUserlist.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mutArrUserInfoList.count
        
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // delete the record on this index.
        if editingStyle == .delete {
            var objUserModel = userInfoModelT()
            objUserModel = mutArrUserInfoList[indexPath.row]
            
            let aDeleteStatus : Bool = userInfoManagerT().DeleteUserDetailInfo(objUserInfo: objUserModel)
            
            if aDeleteStatus == true {
                self.mutArrUserInfoList.remove(at: indexPath.row)
                self.tblUserlist.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellUserList = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as! UserListCell
        
        var objUserModel = userInfoModelT()
        
        objUserModel = mutArrUserInfoList[indexPath.row]
        
        cellUserList.lblUsername.text = objUserModel.name
        cellUserList.lblUserDob.text = objUserModel.dob
        
        return cellUserList
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let objUserModel : userInfoModelT = mutArrUserInfoList[indexPath.row]
        let objAddUserVC = self.storyboard?.instantiateViewController(withIdentifier: "AddUserVC") as? AddUserVCT
        objAddUserVC?.objUserInfoModel = objUserModel
        self.show(objAddUserVC!, sender: self)
    }

}
