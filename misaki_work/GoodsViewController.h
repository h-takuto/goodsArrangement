//
//  UITableViewController+GoodsViewController.h
//  misaki_work
//
//  Created by 早川拓人 on 2017/06/01.
//  Copyright © 2017年 takuto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSString *category;
@property (weak, nonatomic) IBOutlet UITableView *goodsTableView;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectGoogsLabel;
@property (weak, nonatomic) IBOutlet UITextField *goodsNumberField;
- (IBAction)addNumber:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)addQuantity:(id)sender;
- (IBAction)decreaseQuanity:(id)sender;
- (IBAction)ranking:(id)sender;
@end
