//
//  ViewController.swift
//  CardsDemo
//
//  Created by Muhammad Bassio on 11/29/14.
//  Copyright (c) 2014 Muhammad Bassio. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, MABCardsContainerDelegate, MABCardsContainerDataSource,JKPopMenuViewSelectDelegate{
    func loveBizhiUrl ( page:NSInteger)->String {return "http://api.lovebizhi.com/macos_v4.php?a=category&spdy=1&tid=3&order=hot&color_id=3&device=105&uuid=436e4ddc389027ba3aef863a27f6e6f9&mode=0&retina=0&client_id=1008&device_id=31547324&model_id=105&size_id=0&channel_id=70001&screen_width=1920&screen_height=1200&bizhi_width=800&bizhi_height=1200&version_code=19&language=zh-Hans&jailbreak=0&mac=&p=\(page)"}
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var swipeableView:MABCardsContainer!
    var pagenum=0
    var itemArray:NSMutableArray=NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red: 0, green: 176.0/255, blue: 1, alpha: 1)
        
        self.swipeableView = MABCardsContainer(frame: CGRectMake(20, 30, self.view.frame.width-40, self.view.frame.height-158))
        self.swipeableView.setNeedsLayout()
        self.swipeableView.layoutIfNeeded()
        self.swipeableView.dataSource = self;
        self.swipeableView.delegate = self;
        
        var btn = UIButton(frame: CGRectMake(10, 430, 300, 50))
        btn .setTitle("Reload Cards", forState: UIControlState.Normal)
        //btn.backgroundColor = UIColor.blackColor()
        btn.addTarget(self, action: "showPopMenu", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(swipeableView)
        self.view.addSubview(btn)
        getPicList()
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func reload() {
        self.swipeableView.discardAllSwipeableViews()
        self.swipeableView.loadNextSwipeableViewsIfNeeded(true)
        println(QiniuUtiloc.getXAPICloudAppKey())
    }
    
    
    func generateColor() -> UIColor {
        var randomRed:CGFloat = CGFloat(drand48())
        var randomGreen:CGFloat = CGFloat(drand48())
        var randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    func popMenuViewSelectIndex(index:NSInteger)
    {
        //NSLog(@"%s",__func__);
        //  startItemDetilViewController()
        startMyLoveViewController()
    }
    func startItemDetilViewController()// 图片详情
    {
        var storyboard=UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("StoryViewController") as! StoryViewController
        self.presentViewController(vc, animated: true,completion:nil);
        
        
    }
    func startMyLoveViewController(){// 我喜欢的 列表
        var storyboard=UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("MyLoveViewController") as! MyLoveViewController
        self.presentViewController(
            vc, animated: true, completion: {
                println()
                
        })
    }
    func showPopMenu(){//tanpop
        var array=NSMutableArray()
        for index in 1...6  {
            var string="icon\(index)"
            var item=JKPopMenuItem(title:string ,image:UIImage(named: string))
            array.addObject(item)
        }
        var jkpop=JKPopMenuView(items:array as [AnyObject])
        jkpop.delegate=self
        jkpop.show()
        
        
    }
    
    // MABCardsContainerDelegate
    func containerViewDidSwipeLeft(containerView:MABCardsContainer, UIView) {}
    func containerViewDidSwipeRight(containerView:MABCardsContainer, UIView) {}
    func containerViewDidStartSwipingCard(containerView:MABCardsContainer, card:UIView, location:CGPoint) {}
    func containerSwipingCard(containerView:MABCardsContainer, card:UIView, location:CGPoint, translation:CGPoint) {}
    func containerViewDidEndSwipingCard(containerView:MABCardsContainer, card:UIView, location:CGPoint) {}
    
    // MABCardsContainerDataSource
    func nextCardViewForContainerView(containerView:MABCardsContainer) -> UIView! {
        
        if itemArray.count>0
        {
            
            var imageView=UIImageView(frame: CGRect(x: 0, y: 0, width:self.view.frame.width-40, height: self.view.frame.height-171))
            imageView.backgroundColor=UIColor.whiteColor()
            let item=itemArray.objectAtIndex(0) as! PicItem
            itemArray.removeObjectAtIndex(0)
            
            imageView.contentMode=UIViewContentMode.ScaleAspectFit
            imageView.sd_setImageWithURL(NSURL(string:item.identify), completed: { (image, err, _, _) -> Void in
                println(image)
                
                if !(err==nil){
                    println(err)
                }else{
                    //                    imageView.frame=image.
                }
            })
            if itemArray.count==30
            {
                getPicList()
            }
//                var shadowColor2 = UIColor(red: 0.209, green: 0.209, blue: 0.209, alpha: 1)
//                var shadow = shadowColor2.colorWithAlphaComponent(0.73)
//                var shadowOffset = CGSizeMake(3.1/2.0, -0.1/2.0);
//                var shadowBlurRadius = 6.0 as CGFloat
//                imageView.layer.shadowColor = shadow.CGColor
//                imageView.layer.shadowOpacity = 0.73
//                imageView.layer.shadowOffset = shadowOffset
//                imageView.layer.shadowRadius = shadowBlurRadius
//                imageView.layer.shouldRasterize = true
//                
//                imageView.layer.cornerRadius = 10
//            var gesture=UIGestureRecognizer(target: self, action: Selector("startItemDetilViewController"))
//            imageView.addGestureRecognizer(gesture)
            return imageView;
        }
        return nil;
    }
    func getPicList()
    {
        getLovebizhiList()
        //        getPicListFApi()
    }
    func getPicListFApi()// piclist  from the api
    {
        
        let headers = [
            "apikey": "77b2f247303ebca204a45170448412b6"
            
        ]
        let parameters = [
            "num": "40"
        ]
        
        Alamofire.request(.GET, "http://apis.baidu.com/txapi/mvtp/meinv?num=40", headers: headers,parameters:parameters
            )
            .responseJSON { _, _, Json, _ in
                println(Json)
                
                let json=JSON(Json!)
                
                for index in 0...38{
                    let item=json["\(index)"]
                    
                    self.itemArray.addObject(PicItem(identifyorurl:item["picUrl"].string!, title:item["title"].string!, urlFrom:item["url"].string!, description:item["description"].string!))
                }
                self.reload()
        }
        
    }
    
    func getLovebizhiList(){
        Alamofire.request(.GET, loveBizhiUrl(pagenum), headers: nil,parameters:nil
            )
            .responseJSON { _, _, jSON, _ in
                let json=JSON(jSON!)
                
                for(index: String,subjson: JSON) in json["data"]{
                    self.itemArray.addObject(PicItem(identifyorurl:subjson["image"]["original"].string! ))
                }
                self.reload()
        }
        pagenum++
    }
    
}

