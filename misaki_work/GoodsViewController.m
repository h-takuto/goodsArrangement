//
//  UITableViewController+GoodsViewController.m
//  misaki_work
//
//  Created by 早川拓人 on 2017/06/01.
//  Copyright © 2017年 takuto. All rights reserved.
//

#import "GoodsViewController.h"
#import "CustomTableViewCell.h"
#import "DataSingleton.h"

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categoryLabel.text = self.category;
    [DataSingleton sharedManager];
    
    UINib *nib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self.goodsTableView registerNib:nib forCellReuseIdentifier:@"cell"];
}

- (IBAction)addNumber:(id)sender {
    if ([[DataSingleton sharedManager] addGoodsNumber:self.goodsNumberField.text category:self.category]) {
    }
    
    [self.goodsTableView reloadData];
    self.goodsNumberField.text = @"";
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^(void) {
        
    }];
}

- (IBAction)addQuantity:(id)sender
{
    if ([[DataSingleton sharedManager] addGoodsNumber:self.selectGoogsLabel.text category:self.category]) {
    }
    [self.goodsTableView reloadData];
}

- (IBAction)decreaseQuanity:(id)sender
{
    [[DataSingleton sharedManager] removeGoodsNumber:self.selectGoogsLabel.text category:self.category];
    [self.goodsTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *goods = [[DataSingleton sharedManager] getGoodsNumbersCategory:self.category];
    NSSet *set = [NSSet setWithArray:goods];
    NSArray *tmp = [set allObjects];
    return tmp.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    NSArray *goods = [[DataSingleton sharedManager] getGoodsNumbersCategory:self.category];
    NSSet *set = [NSSet setWithArray:goods];
    NSArray *tmp = [set allObjects];
    
    cell.goodsNumberLabel.text = [tmp objectAtIndex:indexPath.row];
    cell.quantityLabel.text = [NSString stringWithFormat:@"%ld", (long)[self sumGoodNumber:[tmp objectAtIndex:indexPath.row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectGoogsLabel.text = cell.goodsNumberLabel.text;
}

- (NSInteger)sumGoodNumber:(NSString *)number
{
    NSInteger sum = 0;
    NSArray *goods = [[DataSingleton sharedManager] getGoodsNumbersCategory:self.category];
    
    for (NSString *goodsNumber in goods) {
        if (number == goodsNumber) {
            sum++;
        }
    }
    return sum;
}
@end
