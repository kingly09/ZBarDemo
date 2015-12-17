//
//  ScanQRCodeView.h
//  LBZBar
//
//  Created by kingly on 15/12/17.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScanQRCodeViewDelegate;

@interface ScanQRCodeView : UIView{

    int num;
    BOOL upOrdown;
    NSTimer * timer;
}

@property (nonatomic,weak) id <ScanQRCodeViewDelegate> myDelegate;

-(void)stopTimer;
/**
 * 可视范围
 */
-(CGRect )previewframe;

@end

/**
 * 二维码视图的协议
 */
@protocol ScanQRCodeViewDelegate <NSObject>

@optional
/**
 * 点击返回
 */
-(void)backAction;
/**
 * 打开相册，读取扫描相片，读取二维码数据
 */
-(void)openPhotoAlbum;

@end