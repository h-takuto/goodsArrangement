//
//  ViewController.h
//  misaki_work
//
//  Created by 早川拓人 on 2017/06/01.
//  Copyright © 2017年 takuto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *categoryField;
@property (weak, nonatomic) IBOutlet UITextField *categoryTypeField;

- (IBAction)addCategory:(id)sender;
- (IBAction)removeData:(id)sender;
- (IBAction)allRanking:(id)sender;
- (IBAction)clothesRanking:(id)sender;
- (IBAction)goodsRanking:(id)sender;

@end

