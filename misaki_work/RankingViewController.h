//
//  UIViewController+RankingView.h
//  misaki_work
//
//  Created by 早川拓人 on 2017/06/02.
//  Copyright © 2017年 takuto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *rankingTableView;
@property NSArray *rankingArray;
- (IBAction)back:(id)sender;
@end
