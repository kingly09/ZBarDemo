//
//  ScanQRCode.h
//  LBZBar
//
//  Created by kingly on 15/12/17.
//  Copyright © 2015年 kingly. All rights reserved.
//
@import UIKit;
@import AVFoundation;

@protocol ScanQRCodeVCDelegate <NSObject>
/**
 * 获得扫描到的二维码内容
 */
- (void) captureQRCode:(NSString* )code;

@end

@interface ScanQRCode : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, strong) UIImageView * line;
@property (nonatomic, weak) id<ScanQRCodeVCDelegate> delegate;

@property (strong,nonatomic) UIImagePickerController *picker;

@end
