//
//  UITableViewCell+CustomTableViewCell.h
//  misaki_work
//
//  Created by 早川拓人 on 2017/06/02.
//  Copyright © 2017年 takuto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *goodsNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@end
