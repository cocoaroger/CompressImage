//
//  CompressedVC.m
//  TestCompressImage
//
//  Created by iSouBu on 16/7/21.
//  Copyright © 2016年 isoubu. All rights reserved.
//

#import "CompressedVC.h"
#import "IDMPhotoBrowser.h"

@interface CompressedVC ()

@property (nonatomic, weak) UIImageView *compressImageView;

@end

@implementation CompressedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"压缩图";
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupImageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.compressImageView.image = self.compressedImage;
}

- (void)setupImageView {
    UIImageView *compressImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    compressImageView.contentMode = UIViewContentModeScaleAspectFit;
    compressImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:compressImageView];
    self.compressImageView = compressImageView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [compressImageView addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    NSLog(@"点击图片");
    if (self.compressedImage) {
        IDMPhoto *photo = [IDMPhoto photoWithImage:self.compressedImage];
        photo.caption = @"压缩图";
        
        // Create and setup browser
        IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:@[photo]];
        
        // Show
        [self presentViewController:browser animated:YES completion:nil];
    }
}

@end
