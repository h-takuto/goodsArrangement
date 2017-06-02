//
//  ViewController.m
//  misaki_work
//
//  Created by 早川拓人 on 2017/06/01.
//  Copyright © 2017年 takuto. All rights reserved.
//

#import "ViewController.h"
#import "DataSingleton.h"

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

@end
