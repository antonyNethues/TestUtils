//
//  UtilityClass.swift
//  TestCoreData
//
//  Created by Admin on 12/20/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func downloadImage(urlString: String){
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            //DispatchQueue.main.async {
                self.image = imageFromCache
            //}
            return
        }
        let loaderObj = MethodList()
        loaderObj.showActivityIndicatory(uiView: self)
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            if data != nil {
                DispatchQueue.main.async {
                    loaderObj.hideActIndicator()
                    let imageToCache = UIImage(data: data!)
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    self.image = imageToCache
                }
            }
            else {
                DispatchQueue.main.async {
                    loaderObj.hideActIndicator()
                }
            }
            }.resume()
    }
}
class UtilityClass: NSObject {

    static let sharedInstance = UtilityClass()
    
    func requestGetFor(reqUrl:String,viewLoader:UIView,viewContLoader:UIViewController, completionHandler: @escaping (_ data : Data,_ error : Error) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: reqUrl)!) { (data2, response, error2) in
            if error2 == nil {
                if data2 != nil {
                    // DispatchQueue.main.async {
                    
                    completionHandler(data2 ?? Data(), error2 ?? NSError() as Error)

                    //self.topImageView.image = UIImage(data: data!)
                    
                    // }
                }
            }
        }
        task.resume()
    }
    func requestForUserDataWith(_ parameters: [String: String],url:String, completionHandler: @escaping (_ data : Data,_ error : Error) -> Void){
        //.. Code process
        var urlReq = URLRequest(url: URL(string: url)!)
        urlReq.httpMethod = "POST"
        urlReq.setValue("application/json", forHTTPHeaderField: "Content-Type")//  // the request is JSON

        do {
            urlReq.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [.prettyPrinted, .sortedKeys])
        }
        catch  {
            print(error.localizedDescription)

        }
        let task = URLSession.shared.dataTask(with: urlReq) { (data2, response, error2) in
            if error2 == nil {
                if data2 != nil {
                    // DispatchQueue.main.async {
                    
                    completionHandler(data2 ?? Data(), error2 ?? NSError() as Error)
                    
                    //self.topImageView.image = UIImage(data: data!)
                    
                    // }
                }
            }
        }
       task.resume()
        
    }
    
    
}
class MethodList: NSObject {
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    var container: UIView = UIView()

    func showActivityIndicatory(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.3)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x:0, y:0, width:80, height:80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        
        actInd.frame = CGRect(x:0.0, y:0.0, width:40.0, height:40.0);
        actInd.style =
            UIActivityIndicatorView.Style.whiteLarge
        actInd.center = CGPoint(x:loadingView.frame.size.width / 2,
                                y:loadingView.frame.size.height / 2);
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
    }
    func hideActIndicator() {
        actInd.stopAnimating()
        container.removeFromSuperview()
    }
    func createSpinnerView(customView:UIView,parentVc:UIViewController) {
//        let child = SpinnerViewController()
//        let wind = UIApplication.shared.delegate?.window
//        // add the spinner view controller
//        .addChild(child)
//        child.view.frame = customView.frame
//        view.addSubview(child.view)
//        child.didMove(toParent: self)
//
//        // wait two seconds to simulate some work happening
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            // then remove the spinner view controller
//            child.willMove(toParent: nil)
//            child.view.removeFromSuperview()
//            child.removeFromParent()
//        }
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        parentVc.present(alert, animated: true, completion: nil)
    }
    static func dismissSpinnerView(customView:UIView,parentVc:UIViewController) {
        parentVc.dismiss(animated: false, completion: nil)
    }

}
