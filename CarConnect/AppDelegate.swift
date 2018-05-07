//
//  AppDelegate.swift
//  CarConnect
//
//  Created by Saurabh Sharma on 10/3/17.
//  Copyright © 2017 Aritron Technologies. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.sharedManager().enable = true
        //UIApplication.shared.statusBarStyle = .lightContent
        return true
    }
    
    class func getDelegate () -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func resetView(){
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil);
        let controller = storyBoard.instantiateViewController(withIdentifier: "SidenavigationController") as! SidenavigationController
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
    }
    func resetView2(){
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil);
        let controller = storyBoard.instantiateViewController(withIdentifier: "SidenavigationController2VC") as! SidenavigationController2VC
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
    }
    func resetView3(){
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil);
        let controller = storyBoard.instantiateViewController(withIdentifier: "SidenavigationController3VC") as! SidenavigationController3VC
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
    }
    
    
    
//    func InstanceViewController() {
//        
//        let rootViewController = self.window!.rootViewController
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let setViewController = mainStoryboard.instantiateViewController(withIdentifier: "BrandDetailViewController") as! BrandDetailViewController
//        rootViewController?.navigationController?.popToViewController(setViewController, animated: false)
//
//    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
       
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        UserDefaults.standard.removeObject(forKey: "skipLog")
    }
    
    
}

