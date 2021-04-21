//
//  MasterViewController.swift
//  masterDetailTemplateXCode11
//
//  Grant Martin
//  Copyright © 2021 Grant G Martin. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    //var objects = [Any]()
    
    var foods = ["American Food", "Chinese Food", "Mexican Food", "Indian Food", "Italian Food", "Indian Food","Middle-Eastern Food", "Fast Food", "Japanese Food"]
    var userText: String?
    let randomSelection = 0
    var temp = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem
        let addButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addTapped))


        self.navigationItem.rightBarButtonItem = addButton
        addButton.target = self
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
    }
    
    //add button functionality
    @objc func addTapped(sender: AnyObject){
        let addAlert = UIAlertController(title:"Add Restaurant", message: "", preferredStyle: .alert)
        addAlert.addTextField()
        addAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak addAlert] (_) in
            let textField = addAlert?.textFields![0].text // Force unwrapping because we know it exists.
            self.foods.append(textField!)
            self.tableView.reloadData()
        }))
        addAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(addAlert, animated: true, completion: nil)
        
    }
    

    
    //random number generator
    @IBAction func randomButton(_ sender: UIButton) {
        let randomSelection = Int.random(in: 0 ... foods.count-1)
        let choice = String(foods[randomSelection]) //cast as string
        let display = "How does " + choice + " sound?"
        let alert = UIAlertController(title: display , message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Let's try again", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    @objc
    func insertNewObject(_ sender: Any) {
        foods.insert(String(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let food = foods[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = food
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = foods[indexPath.row]
        cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           foods.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }


}

