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
 
    class func bg_color()-> UIColor{
        return UIColor(red: 232.0/255, green: 232.0/255, blue: 232.0/255, alpha: 1)
    }
    class func main_color()->UIColor {
        return UIColor(red: 118.0/255, green: 174.0/255, blue: 51/255, alpha: 1)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var swipeableView:MABCardsContainer!
    var pagenum=0
    var itemArray:NSMutableArray=NSMutableArray()
    var source=0
    var temp :String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = ViewController.bg_color()
        self.swipeableView = MABCardsContainer(frame: CGRectMake(20, 30, self.view.frame.width-40, self.view.frame.height-158))
        self.swipeableView.setNeedsLayout()
        self.swipeableView.layoutIfNeeded()
        self.swipeableView.dataSource = self;
        self.swipeableView.delegate = self;
        addHaloLayer()
        getPicList()
//        _=temp.isEmpty
        
    }
    
    func addHaloLayer(){
        let btn = UIButton(frame: CGRectMake(self.view.frame.width/2-50, self.swipeableView.frame.height+30, 100, 100))
        btn .setTitle("+", forState: UIControlState.Normal)
        btn.titleLabel?.font=UIFont .systemFontOfSize(18)
        //btn.backgroundColor = UIColor.blackColor()
        btn.addTarget(self, action: "showPopMenu", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(swipeableView)
        self.view.addSubview(btn)
        let layer=PulsingHaloLayer()
        layer.radius=50
        layer.backgroundColor=ViewController.main_color().CGColor
        layer.position=btn.layer.position
        self.view.layer.addSublayer(layer)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func reload() {
        self.swipeableView.discardAllSwipeableViews()
        self.swipeableView.loadNextSwipeableViewsIfNeeded(true)
        print(QiniuUtiloc.getXAPICloudAppKey())
    }
    
    
    func generateColor() -> UIColor {
        var randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    func popMenuViewSelectIndex(index:NSInteger)
    {
        //NSLog(@"%s",__func__);
        //  startItemDetilViewController()
      
        switch index
        {
        case 0:
            startMyLoveViewController()
        case 1:
            if source != 0
            {
                source=0
                reloadList()
            }
        case 2:
         
            
            if source != 1
            {
                source=1
                reloadList()
            }
            
        case 3:
            self.noticeInfo("建设中", autoClear: true, autoClearTime: 1)
            
        case 4:
            self.noticeInfo("建设中", autoClear: true, autoClearTime: 1)
        case 5:
//            self.noticeInfo("建设中", autoClear: true, autoClearTime: 1)
                let storyboard=UIStoryboard(name: "Main", bundle: nil)
                var vc = storyboard.instantiateViewControllerWithIdentifier("aboutme")
                self.presentViewController(
                    vc, animated: true, completion: {
                        
                })
        default :break
        }
    }
    
    func startMyLoveViewController(){// 我喜欢的 列表
        let storyboard=UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("MyLoveViewController") as! MyLoveViewController
        self.presentViewController(
            vc, animated: true, completion: {
                
        })
    }
    func showPopMenu(){//tanpop
         if !GlobalVariables.notInView()
         {
             startMyLoveViewController()
            return
        }
        var array=NSMutableArray()
        for index in 1...6  {
            var string="icon\(index)"
            var item=JKPopMenuItem(title:"" ,image:UIImage(named: string))
            array.addObject(item)
        }
        var jkpop=JKPopMenuView(items:array as [AnyObject])
        jkpop.delegate=self
        jkpop.show()
    }
    
    func showPopMenuT(){//tanpop
        var array=NSMutableArray()
        if !GlobalVariables.notInView()
        {
//            for index in 1...6  {
//                var string="icon\(index)"
//                var item=JKPopMenuItem(title:"" ,image:UIImage(named: string))
//                array.addObject(item)
//            }
            array.addObject(JKPopMenuItem(title: "", image: UIImage(named: "icon1")))
            array.addObject(JKPopMenuItem(title: "", image: UIImage(named: "icon6")))
//            array.addObject(JKPopMenuItem(title: "", image: UIImage(named: "icon1")))
        }else
        {
            for index in 1...6  {
                var string="icon\(index)"
                var item=JKPopMenuItem(title:"" ,image:UIImage(named: string))
                array.addObject(item)
            }
        }
        var jkpop=JKPopMenuView(items:array as [AnyObject])
        jkpop.delegate=self
        jkpop.show()
    }
    
    // MABCardsContainerDelegate
    func containerViewDidSwipeLeft(containerView:MABCardsContainer, _: UIView) {}
    func containerViewDidSwipeRight(containerView:MABCardsContainer, _ view:UIView) {
        var array=NSMutableArray(contentsOfFile: GlobalVariables.getMyLovePlistPath())
        var url=(view as! UIImageView).sd_imageURL().URLString
        if array?.containsObject(url)==false
        {
            array?.insertObject(url, atIndex: 0)
           var issuccess = array?.writeToFile(GlobalVariables.getMyLovePlistPath(), atomically: true)
            print(issuccess)
        }
        var array1=NSMutableArray(contentsOfFile: GlobalVariables.getMyLovePlistPath())
        
    }
    func containerViewDidStartSwipingCard(containerView:MABCardsContainer, card:UIView, location:CGPoint) {}
    func containerSwipingCard(containerView:MABCardsContainer, card:UIView, location:CGPoint, translation:CGPoint) {}
    func containerViewDidEndSwipingCard(containerView:MABCardsContainer, card:UIView, location:CGPoint) {}
    
    // MABCardsContainerDataSource
    func nextCardViewForContainerView(containerView:MABCardsContainer) -> UIView! {
        
        if itemArray.count>0
        {
            
            var rect = CGRect(x: 0, y: 0, width:self.view.frame.width-40, height: self.view.frame.height-171)
            if source==0
            {rect.size.height=(rect.width)*30/48}
            var imageView=UIImageView(frame: rect)
            imageView.backgroundColor=UIColor.whiteColor()
            let item=itemArray.objectAtIndex(0) as! PicItem
            itemArray.removeObjectAtIndex(0)
            
            imageView.contentMode=UIViewContentMode.ScaleAspectFit
            imageView.sd_setImageWithURL(NSURL(string:item.identify), completed: { (image, err, _, _) -> Void in
                print(image)
                
                if !(err==nil){
                    print(err)
                }else{
                    //                    imageView.frame=image.
                }
            })
            if itemArray.count==30
            {
                getPicList()
            }
            return imageView;
        }
        return nil;
    }
    func getPicList()
    {
        if source==0
        {getLovebizhiList()}
        else
        { getPicListFApi()}
    }
    func reloadList()
    {
        itemArray.removeAllObjects()
        getPicList()
    }
    func getPicListFApi()// piclist  from the api
    {
        
        let headers = [
            "apikey": "77b2f247303ebca204a45170448412b6"
            
        ]
        let parameters = [
            "num": "40"
        ]
        
        
//        Alamofire.request(.GET, "http://apis.baidu.com/txapi/mvtp/meinv?num=40", headers: headers,parameters:parameters
//            )
//            .responseJSON { _, _, Json, _ in
//                println(Json)
//                
//                let json=SwiftyJSON.JSON(Json!)
//                
//                for index in 0...38{
//                    let item=json["\(index)"]
//                    self.itemArray.addObject(PicItem(identifyorurl:item["picUrl"].string!, title:item["title"].string!, urlFrom:item["url"].string!, description:item["description"].string!))
//                }
//                self.reload()
//        }
        Alamofire.request(.GET, "http://apis.baidu.com/txapi/mvtp/meinv?num=40", headers: headers,parameters:parameters
            ).responseJSON { (_, _, result) -> Void in
            let json=SwiftyJSON.JSON(result as! AnyObject)
            
            for index in 0...38{
                let item=json["\(index)"]
                self.itemArray.addObject(PicItem(identifyorurl:item["picUrl"].string!, title:item["title"].string!, urlFrom:item["url"].string!, description:item["description"].string!))
            }
            self.reload()
        }

        
    }
    
    func requestUrl(urlString: String){
        var url: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{
            (response, data, error) -> Void in
            
            if (error != nil) {
                //Handle Error here
            }else{
                //Handle data in NSData type
            }
            
        })
    }
    func getLovebizhiList(){

        
        requestUrl("www.baidu.com")
        if true
        {
            return
        }
        
        let manager=AFHTTPRequestOperationManager()
        manager.GET("http://www.baidu.com", parameters: nil, success: { (AFHTTPRequestOperation, AnyObject) -> Void in
            let a=AnyObject
            }) { (AFHTTPRequestOperation, NSError) -> Void in
                let b=NSError
        }
        
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        [manager GET:@"http://example.com/resources.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"JSON: %@", responseObject);
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"Error: %@", error);
//        }];
        Alamofire.request(.GET, "http://www.baidu.com", parameters: ["foo": "bar"])
            .response { request, response, data, error in
                print(request)
                print(response)
                print(error)
        }
////        Alamofire.request(.GET, GlobalVariables.loveBizhiUrl(pagenum)).respon
//        Alamofire.request(.GET, GlobalVariables.loveBizhiUrl(pagenum)).responseString { (a, b, result) -> Void in
//            let json=SwiftyJSON.JSON(result.data!)
//            
//            for(index: _,subjson) in json["data"]{
//                
//                self.itemArray.addObject(PicItem(identifyorurl:subjson["image"]["original"].string! ))
//            }
//            self.reload()
//        }


        pagenum++
    }
    
}

