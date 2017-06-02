//
//  UIViewController+RankingView.m
//  misaki_work
//
//  Created by 早川拓人 on 2017/06/02.
//  Copyright © 2017年 takuto. All rights reserved.
//

#import "RankingViewController.h"
#import "CustomTableViewCell.h"

@implementation RankingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self.rankingTableView registerNib:nib forCellReuseIdentifier:@"cell"];
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^(void) {
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rankingArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSArray *info = [self.rankingArray objectAtIndex:indexPath.row];
    NSString *goods = [NSString stringWithFormat:@"%@-%@", [info objectAtIndex:2], [info objectAtIndex:1]];
    cell.goodsNumberLabel.text = goods;
    cell.quantityLabel.text = [info objectAtIndex:0];
    return cell;
}


@end
