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
#import "OCHeader.h"
@interface StoryViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

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

    
   
    [SDWebImageDownloader.sharedDownloader downloadImageWithURL: [[NSURL alloc ] initWithString:self.imageUrl]
                                                        options:0
                                                       progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
         // progression tracking code
     }
                                                      completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished)
     {
         if (image && finished)
         {
             // do something with image
             ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:image forSize:CGSizeMake(self.mainTableView.frame.size.width, 300)];
             headerView.headerTitleLabel.text = self.story[@"story"];
             [self.mainTableView setTableHeaderView:headerView];
         }
     }];
    
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
@end
