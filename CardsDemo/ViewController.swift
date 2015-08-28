//
//  ViewController.swift
//  CardsDemo
//
//  Created by Muhammad Bassio on 11/29/14.
//  Copyright (c) 2014 Muhammad Bassio. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, MABCardsContainerDelegate, MABCardsContainerDataSource,JKPopMenuViewSelectDelegate{
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var swipeableView:MABCardsContainer!
    var colorIndex = 0
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
        self.colorIndex = 0
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
    //    - (IBAction)showPopMenu:(id)sender {
    //
    //NSMutableArray *array = [[NSMutableArray alloc]init];
    //for (NSInteger i = 1; i < 7; i++) {
    //NSString *string = [NSString stringWithFormat:@"icon%ld",i];
    //JKPopMenuItem *item = [JKPopMenuItem itemWithTitle:string image:[UIImage imageNamed:string]];
    //[array addObject:item];
    // }
    
    //JKPopMenuView *jkpop = [JKPopMenuView menuViewWithItems:array];
    //jkpop.delegate = self;
    //[jkpop show];
    // }
    
    //#pragma mark App JKPopMenuViewSelectDelegate
    //- (void)popMenuViewSelectIndex:(NSInteger)index
    //{
    
    //}
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
//            var temp=itemArray.objectAtIndex(0).valueForKey("title")as! NSString
//            while (temp.containsString("性感"))&&(temp.containsString("诱惑"))
//            {
//                  itemArray.removeObjectAtIndex(0)
//                temp=itemArray.objectAtIndex(0).valueForKey("picUrl")as! NSString
//
//            }
            var urll=NSURL(string:itemArray.objectAtIndex(0).valueForKey("picUrl")as! String)
            println(itemArray.objectAtIndex(0).valueForKey("title"))
            //            imageView.setImageWithURL(urll!)
            itemArray.removeObjectAtIndex(0)
//            case ScaleToFill
//            case ScaleAspectFit // contents scaled to fit with fixed aspect. remainder is transparent
//            case ScaleAspectFill // contents scaled to fill with fixed aspect. some portion of content may be clipped.
//            case Redraw // redraw on bounds change (calls -setNeedsDisplay)
//            case Center // contents remain same size. positioned adjusted.
//            case Top
//            case Bottom
//            case Left
//            case Right
//            case TopLeft
//            case TopRight
//            case BottomLeft
//            case BottomRight

            imageView.contentMode=UIViewContentMode.ScaleAspectFit
            imageView.sd_setImageWithURL(urll, completed: { (image, err, _, _) -> Void in
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
            return imageView;
        }
        return nil;
    }
    func getPicList()
    {
        
        let headers = [
            "apikey": "77b2f247303ebca204a45170448412b6"
            
        ]
        let parameters = [
            "num": "40"
        ]
        Alamofire.request(.GET, "http://apis.baidu.com/txapi/mvtp/meinv?num=40", headers: headers,parameters:parameters
                )
                .responseJSON { _, _, JSON, _ in
                println(JSON)
                for index in 0...38{
               self.itemArray.addObject(JSON!.valueForKey("\(index)")!)
                }
                self.reload()
       
            
            
        }
    }
    
}

