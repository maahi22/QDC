//
//  AppDelegate.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 20/06/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import FBSDKLoginKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //Fabric.with([Crashlytics.self])
        ///////Push Notification//////
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        /////////
        
        /////////////////
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1] as URL)
        
        setAppNavigationBar()
        setStatusBar()
        configureRootViewController()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    
        FBSDKAppEvents.activateApp()
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "QDCCustomerApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    
    
    /*func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        <#code#>
    }*/

}

extension UINavigationController
{
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
extension AppDelegate{
    
    func configureRootViewController() {
        
        let newWindow = UIWindow(frame: UIScreen.main.bounds)
        
        
        /*guard let mainView = UIStoryboard(name: Screens.SideMenu.rawValue, bundle: nil).instantiateInitialViewController() as? CustomSideMenuViewController
            else{
                return
        }
        newWindow.rootViewController = mainView*/
        if  UserDefaults.standard.bool(forKey: USER_DEFAULT_OTP_CORRECT_KEY) {
            
            guard let mainView = UIStoryboard(name: Screens.SideMenu.rawValue, bundle: nil).instantiateInitialViewController() as? CustomSideMenuViewController
                else{
                    return
            }
            UIApplication.shared.statusBarStyle = .lightContent
            newWindow.rootViewController = mainView 
        }
        else if isForcePinCodeEnabled{
            QDCUserDefaults.setPinCode(pin: PINCODE)
            guard let viewNavController = SelectLocalityVC.getStoryboardInstance()
                else{
                    return
            }
            UIApplication.shared.statusBarStyle = .lightContent
            newWindow.rootViewController = viewNavController
            
            
        }else{
            guard let viewNavController = PincodeTVC.getStoryboardInstance()
                else{
                    return
            }
            UIApplication.shared.statusBarStyle = .lightContent
            newWindow.rootViewController = viewNavController
        }
        
       
        
        newWindow.makeKeyAndVisible()
        newWindow.alpha = 0.0
        
        UIView.animate(withDuration: 0.33, animations: {
            newWindow.alpha = 1.0
            
        }, completion: { _ in
            self.window = newWindow
        })
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate{
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        print("didRegisterForRemoteNotificationsWithDeviceToken \(deviceTokenString)")
        
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        //        if let messageID = userInfo[gcmMessageIDKey] {
        //            print("Message ID: \(messageID)")
        //        }
        //
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        //        if let messageID = userInfo[gcmMessageIDKey] {
        //            print("Message ID: \(messageID)")
        //        }
        
        // Print full message.
        print(userInfo)
        
       /* let aps = userInfo["aps"] as! [String: AnyObject]
        let alertDict = aps["alert"] as! [String: AnyObject]
        var title = ""
        var message = ""
        if let titleStr = alertDict["title"]{
            title = (titleStr as? String)!
        }
        if let msg = alertDict["body"]{
            message = (msg as? String)!
        }
        
        
        
        let alert = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        // show the alert
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)*/
 //       showAlertMessage(vc: self.window, title: title, message: message)
        
//        let alert:UIAlertView  = UIAlertView.init(title: alertDict["title"] as? String, message: alertDict["body"] as? String, delegate: self, cancelButtonTitle: "Ok")
//        alert.show()
        
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
}

