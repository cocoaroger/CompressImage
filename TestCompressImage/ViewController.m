//
//  ViewController.m
//  TestCompressImage
//
//  Created by iSouBu on 16/7/21.
//  Copyright © 2016年 isoubu. All rights reserved.
//

#import "ViewController.h"
#import "OriginVC.h"
#import "CompressedVC.h"
#import "ReactiveCocoa.h"
#import "UIImage+Compress.h"

static const CGFloat kCompressRate = 0.4f; // 默认压缩比例
static const CGFloat k1024 = 1024.f;

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *originLabel;

@property (weak, nonatomic) IBOutlet UILabel *compressLabel;

@property (weak, nonatomic) IBOutlet UITextField *rateTextField;


@property (nonatomic, strong) UIImage *compressImage; // 压缩后的图片

@property (nonatomic, strong) OriginVC *originVC;
@property (nonatomic, strong) CompressedVC *compressVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rateTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.rateTextField.placeholder = @"压缩比例范围0-1，默认0.4";
    
    @weakify(self)
    [[self.rateTextField.rac_textSignal throttle:1] subscribeNext:^(id x) {
        @strongify(self)
        [self caculate];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self caculate];
}

- (void)caculate {
    if (self.originVC.originImage) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 做耗时操作
            // 原图
            UIImage *originImage = self.originVC.originImage;
            NSData *originData = UIImagePNGRepresentation(originImage);
            
            // 压缩图
            NSString *rate = self.rateTextField.text;
            CGFloat compressRate = [rate isEqualToString:@""] ? kCompressRate : [rate floatValue];
            
            NSData *compressedData = [originImage sc_compressImageWithRate:compressRate];
            UIImage *compressedImage = [UIImage imageWithData:compressedData]; // 压缩完成的图片

            dispatch_async(dispatch_get_main_queue(), ^{
                // 在主线程可以执行的处理
                self.compressImage = compressedImage;
                
                /// 计算图片大小,给label设置值
                self.originLabel.text = [NSString stringWithFormat:@"%.2fKB", originData.length / k1024];
                self.compressLabel.text = [NSString stringWithFormat:@"%.2fKB", compressedData.length / k1024];
            });
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (OriginVC *)originVC {
    if (!_originVC) {
        _originVC = [[OriginVC alloc] init];
    }
    return _originVC;
}

- (CompressedVC *)compressVC {
    if (!_compressVC) {
        _compressVC = [[CompressedVC alloc] init];
    }
    return _compressVC;
}

- (IBAction)originAction:(id)sender {
    [self.navigationController pushViewController:self.originVC animated:YES];
}

- (IBAction)compressAction:(id)sender {
    // 计算图片大小
    self.compressVC.compressedImage = self.compressImage;
    [self.navigationController pushViewController:self.compressVC animated:YES];
}
@end
