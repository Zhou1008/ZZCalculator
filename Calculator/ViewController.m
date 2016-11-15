//
//  ViewController.m
//  Calculator
//
//  Created by admin on 16/11/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

{
    
    NSString *_num1;//数1
    NSString *_num2;//数2
    NSString *_transferNum;//中转数
    
    BOOL _isXiaoShu;//是否是小数
    
    NSString *_type;//记录运算的方式
    
    BOOL _isSecond;//判断是第几个数字
    
//    BOOL _isZhengFu;//判断正负
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _num1 = @"0";
    
    
    
}

/*
 AC:清除（tag：99）
 +/-:正负号 （tag：98）
 %：百分号 （tag：97）
 ÷： （tag：96）
 x：（tag：95）
 -：（tag：94）
 +：（tag：93）
 =：（tag：92）
 .：（tag：91）
 0~9：（tag：100~109）
 */


- (IBAction)numberbtnClick:(UIButton *)sender {
    
    if (sender.tag >= 100 && sender.tag <=109) {
        
//        _num1 = 10*_num1 + (sender.tag - 100);
        
        if (_isXiaoShu) {
            
            
            if (_isSecond) {
                
                _num2 = [NSString stringWithFormat:@"%@.%ld", _num2, sender.tag-100];
                
                self.resultLab.text = _num2;
                
            }else{
                
                _num1 = [NSString stringWithFormat:@"%@.%ld", _num1, sender.tag-100];
                
                self.resultLab.text = _num1;
            }
            
            _isXiaoShu = NO;
            
        }else{
            
            if (_isSecond) {
                
                if ([_num2 isEqualToString:@"0"] || _num2 == nil) {
                    
                    _num2 = [NSString stringWithFormat:@"%ld", sender.tag-100];
                    
                }else{
                    
                    _num2 = [NSString stringWithFormat:@"%@%ld", _num2, sender.tag-100];
                    
                }
                
                self.resultLab.text = _num2;
            }else{
                
                if ([_num1 isEqualToString:@"0"]) {
                    
                    _num1 = [NSString stringWithFormat:@"%ld", sender.tag-100];
                    
                }else{
                    
                    _num1 = [NSString stringWithFormat:@"%@%ld", _num1, sender.tag-100];
                    
                }
                
                self.resultLab.text = _num1;
            }
        }
        
        _transferNum = _num2;
        
    }else if(sender.tag == 91){
        
        _isXiaoShu = YES;//点击小数点，开启小数
        
    }else if (sender.tag == 99){//清除
        
        self.resultLab.text = @"0";
        
        _num1 = @"0";
        
        _isXiaoShu = NO;
        
        _isSecond = NO;
        
        _num2 = nil;
        
        _transferNum = nil;
        
    }else if (sender.tag == 98){//正负号
        
        if (_isSecond) {

            if (_num2 == nil) {

                _num2 = @"0";

            }
            if ([_num2 floatValue] < 0) {

                self.resultLab.text = [NSString stringWithFormat:@"%g", -[_num2 floatValue]];
                

            }else{

                self.resultLab.text = [NSString stringWithFormat:@"%@%@", @"-", _num2];
            }
            
            _num2 = self.resultLab.text;

        }else{

            if ([_num1 floatValue] < 0) {

                self.resultLab.text = [NSString stringWithFormat:@"%g", -[_num1 floatValue]];

                
            }else{
                
                 self.resultLab.text = [NSString stringWithFormat:@"%@%@", @"-", _num1];
            }
            
            _num1 = self.resultLab.text;
        }
        _transferNum = _num2;
        
    }else if (sender.tag == 97){//百分号
        
        if (_isSecond) {
            
            self.resultLab.text = [NSString stringWithFormat:@"%@%@", _num2, @"%"];
            
            _num2 = [NSString stringWithFormat:@"%g", [_num2 floatValue]/100.0];
            
            
        }else{
            
            self.resultLab.text = [NSString stringWithFormat:@"%@%@", _num1, @"%"];
            
            _num1 = [NSString stringWithFormat:@"%g", [_num1 floatValue]/100.0];

            
        }
        
        _transferNum = _num2;
  
    }else if (sender.tag >=93 && sender.tag <= 96){//÷ x + -
        
        
        _type = [NSString stringWithFormat:@"%ld", 100- sender.tag];
        
        
        _isSecond = YES;
        
//        _num2 = @"0";
        
        if (_num2.length != 0) {
            
            [self changeResultLab:_type with:_num2];//改变result的text
            
        }
    }else if (sender.tag == 92){// =
        
        
        if (_transferNum.length != 0) {
            
            [self changeResultLab:_type with:_transferNum];//改变result的text
        }
        
        _isSecond = NO;
    }
}

//改变result的text
- (void)changeResultLab:(NSString *)type with:(NSString *)num{
    
    
    switch ([_type integerValue]) {
        case 4://÷
            
        {
            self.resultLab.text = [NSString stringWithFormat:@"%g", [_num1 floatValue] / [num floatValue]];

        }
            break;
        case 5://x
            
        {
            self.resultLab.text = [NSString stringWithFormat:@"%g", [_num1 floatValue] * [num floatValue]];
            
        }
            break;
        case 6://-
            
        {
            self.resultLab.text = [NSString stringWithFormat:@"%g", [_num1 floatValue] - [num floatValue]];
            
        }
            break;
        case 7://÷
            
        {
            self.resultLab.text = [NSString stringWithFormat:@"%g", [_num1 floatValue] + [num floatValue]];
            
        }
            break;
        default:
            break;
    }
    
    _num1 = self.resultLab.text;
    _isXiaoShu = NO;
    _num2 = nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
