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
#import "RankingViewController.h"

@interface GoodsViewController ()
{
    BOOL _isRanking;
}

@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categoryLabel.text = self.category;
    [DataSingleton sharedManager];
    
    UINib *nib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self.goodsTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    self.selectGoogsLabel.text = @"";
}

- (IBAction)addNumber:(id)sender {
    if (self.goodsNumberField.text.length <= 0 && self.goodsNumberField.text.length == nil) {
        return;
    }
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
    if (self.selectGoogsLabel.text.length <= 0 && self.selectGoogsLabel.text.length == nil) {
        return;
    }
    if ([[DataSingleton sharedManager] addGoodsNumber:self.selectGoogsLabel.text category:self.category]) {
    }
    [self.goodsTableView reloadData];
}

- (IBAction)decreaseQuanity:(id)sender
{
    if (self.selectGoogsLabel.text.length <= 0 && self.selectGoogsLabel.text.length == nil) {
        return;
    }
    [[DataSingleton sharedManager] removeGoodsNumber:self.selectGoogsLabel.text category:self.category];
    [self.goodsTableView reloadData];
}

- (IBAction)ranking:(id)sender
{
    [self performSegueWithIdentifier:@"RankingViewController" sender:[self createRanking]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"RankingViewController"]) {
        RankingViewController *rankingVC = segue.destinationViewController;
        rankingVC.rankingArray = sender;
    }
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
        if ([number isEqualToString:goodsNumber]) {
            sum++;
        }
    }
    return sum;
}

- (NSArray *)createRanking
{
    NSArray *goods = [[DataSingleton sharedManager] getGoodsNumbersCategory:self.category];
    NSSet *set = [NSSet setWithArray:goods];
    NSArray *tmp = [set allObjects];
    NSMutableArray *quantityGoods = [[NSMutableArray alloc] init];
    NSMutableArray *quantities = [[NSMutableArray alloc] init];
    
    for (NSString *number in tmp) {
        NSInteger quantity = [self sumGoodNumber:number];
        [quantityGoods addObject:[NSString stringWithFormat:@"%ld-%@-%@", (long)quantity, number, self.category]];
        [quantities addObject:[NSString stringWithFormat:@"%ld", (long)quantity]];
    }
    NSArray *sortedQuantities = [quantities sortedArrayUsingSelector:@selector(compare:)];
    NSArray *reverseSorted = [[sortedQuantities reverseObjectEnumerator] allObjects];
    
    NSMutableArray *ranking = [[NSMutableArray alloc] init];
    for (NSString *quantity in reverseSorted) {
        for (NSString *qg in quantityGoods) {
            NSArray *quanGoods = [qg componentsSeparatedByString:@"-"];
            if ([[quanGoods objectAtIndex:0] isEqualToString:quantity]) {
                [ranking addObject:quanGoods];
                [quantityGoods removeObject:qg];
                break;
            }
        }
    }
    return ranking;
}

@end
