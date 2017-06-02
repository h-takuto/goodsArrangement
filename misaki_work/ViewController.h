//
//  ViewController.h
//  misaki_work
//
//  Created by 早川拓人 on 2017/06/01.
//  Copyright © 2017年 takuto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *goodsNumberField;
@property (weak, nonatomic) IBOutlet UITextField *categoryField;
@property (weak, nonatomic) IBOutlet UITextField *categoryTypeField;

- (IBAction)addGoods:(id)sender;
- (IBAction)addCategory:(id)sender;
- (IBAction)removeData:(id)sender;

@end

