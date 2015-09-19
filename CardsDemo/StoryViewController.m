//
//  ViewController.m
//  ParallaxTableViewHeader
//
//  Created by Vinodh  on 26/10/14.
//  Copyright (c) 2014 Daston~Rhadnojnainva. All rights reserved.
//

#import "StoryViewController.h"
#import "ParallaxHeaderView.h"
#import "StoryCommentCell.h"
#import "meizi-swift.h"
#import "CorePhotoBroswerVC/PhotoBroswerVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
//#import "PicItem.swift"
@interface StoryViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property  ParallaxHeaderView *headerView;
@property (nonatomic) NSDictionary *story;
@end

@implementation StoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Load Dummy PlaceHolder Comments
    [self loadPlaceHolderComments];
    
    // Set TableViewWidth to the storyCommentCell so that comment cell is layouts itself for all ios Devices
    [StoryCommentCell setTableViewWidth:self.mainTableView.frame.size.width];    
    
    // Create ParallaxHeaderView with specified size, and set it as uitableView Header, that's it

    
   
//    [SDWebImageDownloader.sharedDownloader downloadImageWithURL: [[NSURL alloc ] initWithString:((PicItem*)_picItem).identify]
//                                                        options:0
//                                                       progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
         // progression tracking code
     }
                                                      completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished)
     {
         if (image && finished)
         {
             // do something with image
             _headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:image forSize:CGSizeMake(self.mainTableView.frame.size.width, 300)];
             _headerView.headerTitleLabel.text = self.story[@"story"];
             [self.mainTableView setTableHeaderView:_headerView];
             UIGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageClick)];
             [_headerView addGestureRecognizer:(recognizer)];
         }
     };
}

- (void)viewDidAppear:(BOOL)animated
{
    [(ParallaxHeaderView *)self.mainTableView.tableHeaderView refreshBlurViewForNewImage];
    [super viewDidAppear:animated];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


#pragma mark -
#pragma mark UITableViewDatasource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numOfRows = [self.story[kCommentsKey] count];
    return numOfRows;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0.0;
    NSDictionary *commentDetails = self.story[kCommentsKey][indexPath.row];
    NSString *comment = commentDetails[kCommentKey];
    
    cellHeight += [StoryCommentCell cellHeightForComment:comment];
    return cellHeight;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [self customCellForIndex:indexPath];
    NSDictionary *comment = self.story[kCommentsKey][indexPath.row];
    [(StoryCommentCell *)cell  configureCommentCellForComment:comment];
    return cell;
}

#pragma mark -
#pragma mark UISCrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.mainTableView)
    {
        // pass the current offset of the UITableView so that the ParallaxHeaderView layouts the subViews.
        [(ParallaxHeaderView *)self.mainTableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}

#pragma mark -
#pragma mark Private

- (void)loadPlaceHolderComments
{
    NSMutableDictionary *story = [NSMutableDictionary dictionary];
    story[@"story"] = @"";
    story[@"likes"] = @1;
    
    
    NSArray *comments = @[
                          @{kCommentKey: @"评论功能马上上线，妹子在这里等你哦！", kTimeKey : @"刚刚", kLikesCountKey : @"3"},

                          ];
    
    [story setObject:comments forKey:kCommentsKey];
    self.story = story;
}

- (UITableViewCell *)customCellForIndex:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSString * detailId = kCellIdentifier;
    cell = [self.mainTableView dequeueReusableCellWithIdentifier:detailId];
    if (!cell)
    {
        cell = [StoryCommentCell storyCommentCellForTableWidth:self.mainTableView.frame.size.width];
    }
    return cell;
}
- (IBAction)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void) showImageClick
{
//    PhotoBrowser *photoBrowser=[[PhotoBrowser alloc] init];
//
//    [Swift2OC showHost:( [((PicItem*)_picItem) getPicUrl1920_1200]) image:(nil) fromView:(_headerView) fromVC:(self)];
    [self networkImageShow];
//    
}

-(void)networkImageShow{
//    
//    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeModal index:<#(NSUInteger)#> photoModelBlock:<#^NSArray *(void)photoModelBlock#>]
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeModal index:2 photoModelBlock:^NSArray *{
        
        
        NSArray *networkImages=@[
                                 @"http://www.fevte.com/data/attachment/forum/day_110425/110425102470ac33f571bc1c88.jpg",
                                 @"http://www.netbian.com/d/file/20150505/5a760278eb985d8da2455e3334ad0c0f.jpg",
                                 @"http://www.netbian.com/d/file/20141006/e9d6f04046d483843d353d7a301d36f8.jpg",
                                 @"http://www.netbian.com/d/file/20130906/134dca4108f3f0ed10a4cc3f78848856.jpg",
                                 @"http://www.netbian.com/d/file/20121111/a03b9adb18a982f6a49aa7bfa7b82371.jpg",
                                 @"http://www.netbian.com/d/file/20130421/e0dabeee4e1e62fe114799bc7e4ccd66.jpg",
                                 @"http://www.netbian.com/d/file/20121012/c890c1da17bb5b4291e9733fad8efb42.jpg",
                                 @"http://www.netbian.com/d/file/20150318/c5c68492a4d6998229d1b6068c77951e.jpg0"
                                 ];
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:networkImages.count];
        for (NSUInteger i = 0; i< networkImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image_HD_U = networkImages[i];
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
        
        
    }];
}




@end
