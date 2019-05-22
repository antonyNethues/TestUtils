//
//  UtilityTestViewController.swift
//  
//
//  Created by Admin on 5/8/19.
//

import UIKit
import RichEditorView
public extension UIViewController {
    
    /// Adds child view controller to the parent.
    ///
    /// - Parameter child: Child view controller.
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    /// It removes the child view controller from the parent.
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
class UtilityTestViewController: UIViewController,RichEditorDelegate,RichEditorToolbarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let editor = RichEditorView(frame: self.view.bounds)
//        editor.html = "hi "
//        self.view.addSubview(editor)
//        editor.delegate = self
//
//        let toolbar = RichEditorToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
//        toolbar.options = RichEditorDefaultOption.all
//        toolbar.editor = editor // Previously instantiated RichEditorView
//        toolbar.delegate = self
//
//        editor.inputAccessoryView = toolbar
        
        self.add(ZSTestViewController())
        

        // Do any additional setup after loading the view.
    }
    private func randomColor() -> UIColor {
        let colors: [UIColor] = [
            .red, .orange, .yellow,
            .green, .blue, .purple
        ]
        
        let color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        return color
    }
    
    func richEditorToolbarChangeTextColor(toolbar: RichEditorToolbar) {
        let color = randomColor()
        toolbar.editor?.setTextColor(color)
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
