//
//  AccountTableViewController.swift
//  SocialApp
//
//  Created by Игорь Пенкин on 14.10.2020.
//

import UIKit

class AccountTableViewController: UITableViewController {
    
    @IBOutlet weak var accountTableView: UITableView!
    
    @IBAction func signOutButton(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "userLogin")
        UserDefaults.standard.synchronize()
        UserDefaults.standard.set(nil, forKey: "userPassword")
        UserDefaults.standard.synchronize()
        
//        self.parent?.dismiss(animated: true, completion: {print("Dismissed parent")})
//        self.dismiss(animated: true, completion: { print("Dismissed AccountTVC") })
        
        let controllerName: String = "WebLoginViewController"
        guard
            let vc = storyboard?.instantiateViewController(identifier: controllerName),
            let window = self.view.window
        else { return }
        window.rootViewController = vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountTableView.dataSource = self
        accountTableView.delegate = self
        accountTableView.rowHeight = accountTableView.bounds.width
        //accountTableView.estimatedRowHeight = accountTableView.frame.width
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        print("\nINFO: AccountTableViewController is loaded from parent: " + (self.parent?.debugDescription ?? "AccountTableViewController has no parent."))
        
        // Just to try work with Operation
        let operaionQueue = OperationQueue()
        let request = NetworkManager.biuldRequest()
        let networkOperation = NetworkOperation(request: request)
        networkOperation.completionBlock = {
            print("\nINFO: NetworkOperation has done for \(request.cURLDescription())")
        }
        operaionQueue.addOperation(networkOperation)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as! AccountTableViewCell

        cell.contentView.layer.backgroundColor = UIColor.white.cgColor
        cell.animateLoading()
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
