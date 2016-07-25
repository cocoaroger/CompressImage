//
//  OriginVC.m
//  TestCompressImage
//
//  Created by iSouBu on 16/7/21.
//  Copyright © 2016年 isoubu. All rights reserved.
//

#import "OriginVC.h"
#import "IDMPhotoBrowser.h"

@interface OriginVC ()<
    UIActionSheetDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate>


@property (nonatomic, weak) UIImageView *originImageView;
@end

@implementation OriginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"原图";
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupRightItem];
    [self setupImageView];
}

- (void)setupRightItem {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(addImageAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setupImageView {
    UIImageView *originImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    originImageView.contentMode = UIViewContentModeScaleAspectFit;
    originImageView.userInteractionEnabled = YES;
    [self.view addSubview:originImageView];
    self.originImageView = originImageView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [originImageView addGestureRecognizer:tap];
}

- (void)addImageAction {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选图片"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册选择",nil];
    [actionSheet showInView:self.view];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    NSLog(@"点击图片");
    if (self.originImage) {
        IDMPhoto *photo = [IDMPhoto photoWithImage:self.originImage];
        photo.caption = @"原图";
        
        // Create and setup browser
        IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:@[photo]];
        // Show
        [self presentViewController:browser animated:YES completion:nil];
    }
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *originImage = info[UIImagePickerControllerOriginalImage];
    self.originImageView.image = originImage;
    self.originImage = originImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.delegate = self;
        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pickerController animated:YES completion:nil];
        
    } else if (buttonIndex == 1) {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.delegate = self;
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pickerController animated:YES completion:nil];
    }
}

@end
