//  PageViewController.swift
//  FitQ
//  Created by vishnu.kumar on 26/12/19.
//  Copyright © 2019 appmantras. All rights reserved.


import UIKit
class PageViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var nextbutton: UIButton!
    @IBOutlet weak var skipbutton: UIButton!
    @IBOutlet weak var backbutton: UIButton!
 var scrollView = UIScrollView()
    @IBOutlet weak var Imageview: UIImageView!
    @IBOutlet weak var Pagecontrol: UIPageControl!
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.frame =  CGRect(x:0, y:100, width:self.view.frame.width,height: nextbutton.frame.origin.y-80)

        Pagecontrol.numberOfPages = 4
        Pagecontrol.pageIndicatorTintColor = UIColor.yellow
        Pagecontrol.currentPageIndicatorTintColor = UIColor.blue
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        self.view.addSubview(scrollView)
        for index in 0..<4 {
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            
           
            let subView = UIView(frame: frame)
            subView.backgroundColor = colors[index]
            self.scrollView .addSubview(Imageview)
        }
        
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 4,height: self.scrollView.frame.size.height)
        Pagecontrol.addTarget(self, action: #selector(changePage), for: UIControl.Event.valueChanged)
        // Do any additional setup after loading the view.
    }
    
   
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(Pagecontrol.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        Pagecontrol.currentPage = Int(pageNumber)
        
        switch  Pagecontrol.currentPage {
            
        case 0:
            Imageview.image = UIImage(named: "13")
        case 1:
            Imageview.image = UIImage(named: "nature")
        case 2:
            Imageview.image = UIImage(named: "13")
        default:
            Imageview.image = UIImage(named: "nature")
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        Pagecontrol.currentPage = Int(pageNumber)
        
        switch  Pagecontrol.currentPage {
            
        case 0:
            
            Imageview.image = UIImage(named: "13")
            
        case 1:
            
            Imageview.image = UIImage(named: "nature")
            
        case 2:
            Imageview.image = UIImage(named: "13")
      
            
        default:
            Imageview.image = UIImage(named: "nature")
        }
        
    }

        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


