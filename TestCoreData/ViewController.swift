//
//  ViewController.swift
//  TestCoreData
//
//  Created by Admin on 12/17/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreData
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topImageView: UIImageView!
    var personsArr: [NSManagedObject] = []
    let rest = RestManager()

    
    func createUser() {
        guard let url = URL(string: "http://mage23new.newsoftdemo.info/rest/V1/adminapp/order_list/") else { return }
        
        rest.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        rest.httpBodyParameters.add(value: "1", forKey: "store_id")
        rest.httpBodyParameters.add(value: "admin", forKey: "username")
        rest.httpBodyParameters.add(value: "iOS", forKey: "device_type")
        rest.httpBodyParameters.add(value: "desc", forKey: "id_sort")
        rest.httpBodyParameters.add(value: "10", forKey: "limit")
        rest.httpBodyParameters.add(value: "1", forKey: "page")
        rest.httpBodyParameters.add(value: "", forKey: "price_sort")
        rest.httpBodyParameters.add(value: "cSNcr_hIZ2E:APA91bFOmubnupEbLc-UfV2yLBIdBvgc_RV4QHmPhcGSFHjZSxdQPrDhFSfT_2BhPd0530XGB6TCgmui56eXi9tIKT0oh8GaKgyDxePvIxVAIR-hyJm-5JtdHFFjhr9f51mdQBzdV25U", forKey: "device_token")
        
        rest.makeRequest(toURL: url, withHttpMethod: .post) { (results) in
            guard let response = results.response else { return }
            if response.httpStatusCode == 201 {
                guard let data = results.data else { return }
                let decoder = JSONDecoder()
               // guard let jobUser = try? decoder.decode(JobUser.self, from: data) else { return }
               // print(jobUser.description)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "The List"
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
        //self.createSpinnerView()
        self.authenticateUserUsingTouchId()
        
        //self.createUser()
       // return
        let imageUrl = "http://mage23new.newsoftdemo.info/rest/V1/adminapp/order_list/"//"https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA05982_hires.jpg"
        UtilityClass.sharedInstance.requestForUserDataWith(["store_id" : "1","device_token":"cSNcr_hIZ2E:APA91bFOmubnupEbLc-UfV2yLBIdBvgc_RV4QHmPhcGSFHjZSxdQPrDhFSfT_2BhPd0530XGB6TCgmui56eXi9tIKT0oh8GaKgyDxePvIxVAIR-hyJm-5JtdHFFjhr9f51mdQBzdV25U","username":"admin","device_type":"iOS","id_sort":"desc","limit":"10","page":"1","price_sort":""], url: imageUrl) { (data, error) in
            print(data)
            do {
                let decoded = try JSONSerialization.jsonObject(with: data, options: [])
                // here "decoded" is of type `Any`, decoded from JSON data
                if let dictFromJSON = decoded as? [[String:AnyObject]] {
                    print(dictFromJSON)

                }

            }
            catch {
                
            }
            
                
                // you can now cast it with the right type
                // use dictFromJSON
            }
        
//        UtilityClass.sharedInstance.requestGetFor(reqUrl: imageUrl, viewLoader: self.view, viewContLoader: self) { (data, error) in
//            DispatchQueue.main.async {
//
//                self.topImageView.downloadImage(urlString: imageUrl)
//
//            }
//        }
    }
    fileprivate func authenticateUserUsingTouchId() {
        let context = LAContext()
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: nil) {
            self.evaulateTocuhIdAuthenticity(context: context)
        }
    }
    func evaulateTocuhIdAuthenticity(context: LAContext) {
        guard let lastAccessedUserName = UserDefaults.standard.object(forKey: "lastAccessedUserName") as? String else { return }
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: lastAccessedUserName) { (authSuccessful, authError) in
            if authSuccessful {
                
            } else {
                if let error = authError as? LAError {
                    //showError(error: error)
                }
            }
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        //3
        do {
            personsArr = try managedContext.fetch(fetchRequest)
            self.tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    

    @IBAction func addName(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
                                        [unowned self] action in
                                        
                                        guard let textField = alert.textFields?.first,
                                            let nameToSave = textField.text else {
                                                return
                                        }
                                        
                                        self.save(name: nameToSave)
                                        self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    func save(name: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Person",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        person.setValue(name, forKeyPath: "name")
        
        // 4
        do {
            try managedContext.save()
            personsArr.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}
// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "Cell",
                                              for: indexPath)
            
            //cell.textLabel?.text = personsArr[indexPath.row].value(forKeyPath: "name") as? String
            return cell
    }
    
}
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let imageUrl = "https://placehold.it/120x120&text=image0\(indexPath.row)"//"https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA05982_hires.jpg"//
        cell.imageView?.downloadImage(urlString: imageUrl)
        
    }
    
}

