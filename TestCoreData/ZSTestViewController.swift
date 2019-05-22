//
//  ZSTestViewController.swift
//  TestCoreData
//
//  Created by Admin on 5/8/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
//import ZSSRichTextEditor

class ZSTestViewController: ZSSRichTextEditor {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Set Custom CSS
        var customCSS = ""
        //        self.CSS = customCSS
        self.setCSS(customCSS)
        
        alwaysShowToolbar = true
        receiveEditorDidChangeEvents = false
        
        // Export HTML
        //        navigationItem?.rightBarButtonItem = UIBarButtonItem(title: "Export", style: .plain, target: self, action: #selector(self.exportHTML))
        
        // HTML Content to set in the editor
        var html = """
   <div class='test'></div><!-- This is an HTML comment -->\
   <p>This is a test of the <strong>ZSSRichTextEditor</strong> by <a title="Zed Said" href="http://www.zedsaid.com">Zed Said Studio</a></p>
   """
        
        // Set the base URL if you would like to use relative links, such as to images.
        baseURL = URL(string: "http://www.zedsaid.com")
        shouldShowKeyboard = false
        // Set the HTML contents of the editor
        self.placeholder = "This is a placeholder that will show when there is no content(html)"
        
        //        self.HTML = html
        self.setHTML(html)
    } 
    //  Converted to Swift 4 by Swiftify v4.2.28451 - https://objectivec2swift.com/
    override func showInsertURLAlternatePicker() {
        
        dismissAlertView()
        
        let picker = HRColorPickerViewController()
       // picker.demoView = self
        let nav = UINavigationController(rootViewController: picker)
        nav.navigationBar.isTranslucent = false
        present(nav, animated: true)
        
    }
    
    override func showInsertImageAlternatePicker() {
        
        dismissAlertView()
        
        let picker = HRColorPickerViewController()
        //picker.demoView = self
       // picker.isInsertImagePicker = true
        let nav = UINavigationController(rootViewController: picker)
        nav.navigationBar.isTranslucent = false
        present(nav, animated: true)
        
    }
    
    func exportHTML() {
        
        print("\(getHTML())")
        
    }
    
    override func editorDidChange(withText text: String?, andHTML html: String?) {
        
        print("Text Has Changed: \(text ?? "")")
        
        print("HTML Has Changed: \(html ?? "")")
        
    }
    
    override func hashtagRecognized(withWord word: String?) {
        
        print("Hashtag has been recognized: \(word ?? "")")
        
    }
    
    override func mentionRecognized(withWord word: String?) {
        
        print("Mention has been recognized: \(word ?? "")")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
