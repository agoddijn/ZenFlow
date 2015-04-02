//
//  StartViewController.swift
//  ZenFlow3
//
//  Created by Alexander Goddijn on 14/03/2015.
//  Copyright (c) 2015 Alexander Goddijn. All rights reserved.
//

import UIKit

class StartViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var controllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for subView in self.view.subviews as [UIView] {
            if let scrollView = subView as? UIScrollView {
                scrollView.delaysContentTouches = false
            }
        }
        
        controllers.append(self.storyboard!.instantiateViewControllerWithIdentifier("capture")! as UIViewController)
        controllers.append(self.storyboard!.instantiateViewControllerWithIdentifier("flow2")! as UIViewController)
        self.dataSource = self
        self.delegate = self
        self.setViewControllers([controllers[0]], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        // Do any additional setup after loading the view.
    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [AnyObject]) {
        if let destination = pendingViewControllers.first as? FlowViewController {
            var curController = controllers.first as CaptureViewController
            destination.myManager = curController.myManager
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if (viewController == controllers[0]) {
            return controllers[1]
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if (viewController == controllers[1]) {
            return controllers[0]
        } else {
            return nil
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
