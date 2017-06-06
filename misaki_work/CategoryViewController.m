//
//  UITableViewController+CategoryViewController.m
//  misaki_work
//
//  Created by 早川拓人 on 2017/06/02.
//  Copyright © 2017年 takuto. All rights reserved.
//

#import "CategoryViewController.h"
#import "GoodsViewController.h"
#import "DataSingleton.h"

@implementation CategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [DataSingleton sharedManager];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[DataSingleton sharedManager] getCategories].allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSArray *categories = [self sortCategory];
    cell.textLabel.text = [categories objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [[DataSingleton sharedManager] removeCategory:cell.textLabel.text];
    }
    [tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"GoodsViewController" sender:cell.textLabel.text];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GoodsViewController *goodsVC = segue.destinationViewController;
    goodsVC.category = sender;
}

- (NSArray *)sortCategory
{
    NSDictionary *dic = [[DataSingleton sharedManager] getCategories];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (id key in [dic keyEnumerator]) {
        if ([[dic valueForKey:key] isEqualToString:@"9"]) {
            [array addObject:key];
        }
    }
    for (id key in [dic keyEnumerator]) {
        if ([[dic valueForKey:key] isEqualToString:@"10"]) {
            [array addObject:key];
        }
    }
    for (id key in [dic keyEnumerator]) {
        if (![[dic valueForKey:key] isEqualToString:@"9"] && ![[dic valueForKey:key] isEqualToString:@"10"]) {
            [array addObject:key];
        }
    }
    
    return array;
}

@end
