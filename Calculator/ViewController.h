//
//  ViewController.h
//  Calculator
//
//  Created by admin on 16/11/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *resultLab;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBTN;
@end

