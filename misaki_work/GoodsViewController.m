//
//  UITableViewController+GoodsViewController.m
//  misaki_work
//
//  Created by 早川拓人 on 2017/06/01.
//  Copyright © 2017年 takuto. All rights reserved.
//

#import "GoodsViewController.h"
#import "DataSingleton.h"

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categoryLabel.text = self.category;
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^(void) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[DataSingleton sharedManager] getCategories].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSArray *categories = [[DataSingleton sharedManager] getCategories].allKeys;
    cell.textLabel.text = [categories objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
