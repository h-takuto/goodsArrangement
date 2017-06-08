//
//  ViewController.m
//  misaki_work
//
//  Created by 早川拓人 on 2017/06/01.
//  Copyright © 2017年 takuto. All rights reserved.
//

#import "ViewController.h"
#import "DataSingleton.h"
#import "RankingViewController.h"

@interface ViewController ()
{
    NSUserDefaults *_userDefault;
    NSMutableArray *_goodsNumber;
    NSMutableDictionary *_category;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [DataSingleton sharedManager];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addCategory:(id)sender
{
    if (self.categoryField.text.length > 0) {
        [[DataSingleton sharedManager] saveCategoriesObject:self.categoryTypeField.text forKey:self.categoryField.text];
        self.categoryField.text = @"";
        self.categoryTypeField.text = @"";
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:@"同じカテゴリがあるか入力されてないよ" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)removeData:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"データを削除します" message:@"消していい時は\"OK\"を押してね" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[DataSingleton sharedManager] removeCategories];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)allRanking:(id)sender
{
    [self performSegueWithIdentifier:@"RankingViewController" sender:[self createAllRanking]];
}

- (IBAction)clothesRanking:(id)sender
{
    [self performSegueWithIdentifier:@"RankingViewController" sender:[self createClothesRanking]];
}

- (IBAction)goodsRanking:(id)sender
{
    [self performSegueWithIdentifier:@"RankingViewController" sender:[self createGoodsRanking]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"RankingViewController"]) {
        RankingViewController *rankingVC = segue.destinationViewController;
        rankingVC.rankingArray = sender;
    }
}

- (NSInteger)sumGoodNumber:(NSString *)number
{
    NSInteger sum = 0;
    NSArray *goods = [[DataSingleton sharedManager] getAllCategoryGoods];
    
    for (NSString *goodsNumber in goods) {
        if ([number isEqualToString:goodsNumber]) {
            sum++;
        }
    }
    return sum;
}

- (NSArray *)createAllRanking
{
    NSArray *goods = [[DataSingleton sharedManager] getAllCategoryGoods];
    NSSet *set = [NSSet setWithArray:goods];
    NSArray *tmp = [set allObjects];
    NSMutableArray *quantityGoods = [[NSMutableArray alloc] init];
    NSMutableArray *quantities = [[NSMutableArray alloc] init];
    
    for (NSString *number in tmp) {
        NSInteger quantity = [self sumGoodNumber:number];
        [quantityGoods addObject:[NSString stringWithFormat:@"%ld-%@", (long)quantity, number]];
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

- (NSArray *)createClothesRanking
{
    NSArray *goods = [[DataSingleton sharedManager] getCategoryGoods:@"9"];
    NSSet *set = [NSSet setWithArray:goods];
    NSArray *tmp = [set allObjects];
    NSMutableArray *quantityGoods = [[NSMutableArray alloc] init];
    NSMutableArray *quantities = [[NSMutableArray alloc] init];
    
    for (NSString *number in tmp) {
        NSInteger quantity = [self sumGoodNumber:number];
        [quantityGoods addObject:[NSString stringWithFormat:@"%ld-%@", (long)quantity, number]];
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

- (NSArray *)createGoodsRanking
{
    NSArray *goods = [[DataSingleton sharedManager] getCategoryGoods:@"10"];
    NSSet *set = [NSSet setWithArray:goods];
    NSArray *tmp = [set allObjects];
    NSMutableArray *quantityGoods = [[NSMutableArray alloc] init];
    NSMutableArray *quantities = [[NSMutableArray alloc] init];
    
    for (NSString *number in tmp) {
        NSInteger quantity = [self sumGoodNumber:number];
        [quantityGoods addObject:[NSString stringWithFormat:@"%ld-%@", (long)quantity, number]];
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
